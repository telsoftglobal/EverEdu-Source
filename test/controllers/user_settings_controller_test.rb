require 'test_helper'

class UserSettingsControllerTest < ActionController::TestCase
  test "should get language" do
    get :language
    assert_response :success
  end

end
