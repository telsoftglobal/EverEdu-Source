require 'test_helper'

class UserSettings < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "initDataa" do

    Language.new(id:'ja',name:'Japanese').save
    Language.new(id:'en',name:'United States').save
    Language.new(id:'vi',name:'Vietnamese').save

# a =     Language.all
#     puts ''
  end

end
