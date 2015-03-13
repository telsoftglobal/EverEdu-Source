require 'test_helper'
require 'amazon/aws/search'
include Amazon::AWS
include Amazon::AWS::Search
class Amazon_affTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "insert a record" do
    is = ItemSearch.new( 'Books', { 'Keywords' => 'Ruby In A Day'} )
    is.response_group = ResponseGroup.new( 'Large' )

    req = Request.new
    req.locale = 'us'

    resp = req.search( is )
    items = resp.item_search_response[0].items[0].item

    printf( "Search returned %d items.\n", items.size )

    items.each { |item| puts item, '\n----------------------------------------------' }
    resp = req.search( is, :ALL_PAGES )
  end

end
