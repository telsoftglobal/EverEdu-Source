require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
