require 'test_helper'
require 'amazon/aws/search'
include Amazon::AWS
include Amazon::AWS::Search

class Amazon_affTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "insert a record" do

    tl = TransactionLookup.new( '103-5663398-5028241' )
    tl.response_group = ResponseGroup.new( 'TransactionDetails' )

    req = Request.new
    req.locale = 'us'

    resp = req.search( tl )
    trans = resp.transaction_lookup_response.transactions.transaction

    printf( "Transaction date was %s.\n", trans.transaction_date )
    printf( "It was in the amount of %s and the seller was %s.\n",
            trans.totals.total.formatted_price, trans.seller_name )
    printf( "The shipping charge was %s and the package was sent by %s.\n",
            trans.totals.shipping_charge.formatted_price,
            trans.shipments.shipment.delivery_method )

  end

end
