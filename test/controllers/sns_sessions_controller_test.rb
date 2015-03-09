require 'test_helper'

# Class Name: SnsSessionControllerTest
# Description: The class containers test cases for SnsSessionController class
# Version: 1.0
# Copyright: Telsoft
# Author: HaPT
# Create Date: 29/10/2014
# Modify Date:
class SnsSessionsControllerTest < ActionController::TestCase
  setup do
    OmniAuth.config.test_mode = true
  end

  # Description: sign up successful with case: facebook account not exist, user_name and email not exist
  # @author: HaPT
  # Create Date: 29/10/2014
  # Modify Date:
  test "sign up facebook successful" do
    #init test delete user with user_name = huyendt and email = 'huyendt@telsoft.com.vn'
    User.delete_all(user_name: 'haptfacebook')
    User.delete_all(email: 'phanha9389facebook@gmail.com')
    set_ommniauth_facebook
    get :create
    #assert_redirected_to signup_sns_path
    #request post signup
    post :signup_sns, :user => {:first_name => 'Ha', :last_name => 'Phan', :user_name => 'haptfacebook',
                                :email => 'phanha9389facebook@gmail.com', :sns_accounts_attributes => [:provider => 'facebook', :uid => 'fb123545', :user_name => 'haptfacebook',
                                                                                                       :first_name => 'Phan', :last_name => 'Ha', :email => 'phanha9389facebook@gmail.com',
                                                                                                       :image_url => 'http://', :access_token => '4328473824']}
    user = User.find_by(user_name: 'haptfacebook')
    assert_not user.nil?
    assert_equal session["user_id"], user.id
    assert_redirected_to student_index_path
  end

  # Description: sign up successful with case: google account not exist, user_name and email not exist
  # @author: HaPT
  # Create Date: 29/10/2014
  # Modify Date:
  test "sign up google successful" do
    User.delete_all(user_name: 'haptgoogle')
    User.delete_all(email: 'phanha9389google@gmail.com')
    set_ommniauth_google
    get :create
    #assert_redirected_to signup_sns_path
    #request post signup
    post :signup_sns, :user => {:first_name => 'Ha', :last_name => 'Phan', :user_name => 'haptgoogle',
                                :email => 'phanha9389google@gmail.com', :sns_accounts_attributes => [:provider => 'google', :uid => 'gl123545', :user_name => 'haptgoogle',
                                                                                                     :first_name => 'Phan', :last_name => 'Ha', :email => 'phanha9389google@gmail.com',
                                                                                                     :image_url => 'http://', :access_token => '4328473824']}
    user = User.find_by(user_name: 'haptgoogle')
    assert_not user.nil?
    assert_equal session["user_id"], user.id
    assert_redirected_to student_index_path
  end

  # Description: sign up successful with case: twitter account not exist, user_name and email not exist
  # @author: HaPT
  # Create Date: 29/10/2014
  # Modify Date:
  test "sign up twitter successful" do
    User.delete_all(user_name: 'hapttwitter')
    User.delete_all(email: 'phanha9389twitter@gmail.com')
    set_ommniauth_twitter
    get :create
    #assert_redirected_to signup_sns_path
    #request post signup
    post :signup_sns, :user => {:first_name => 'Ha', :last_name => 'Phan', :user_name => 'hapttwitter',
                                :email => 'phanha9389twitter@gmail.com', :sns_accounts_attributes => [:provider => 'twitter', :uid => 'tw1234567', :user_name => 'hapttwitter',
                                                                                                      :first_name => '', :last_name => '', :email => '',
                                                                                                      :image_url => 'http://', :access_token => '4328473824']}
    user = User.find_by(user_name: 'hapttwitter')
    assert_not user.nil?
    assert_equal session["user_id"], user.id
    assert_redirected_to student_index_path
  end

  # Description: sign up successful with case: facebook account not exist, email exist
  # @author: HaPT
  # Create Date: 29/10/2014
  User.delete_all(user_name: 'hapt')
  # Modify Date:
  test "sign up successful with sns not exist and email exist" do
    User.delete_all(email: 'phanha9389facebook@gmail.com')
    user = User.new
    user.first_name = 'Ha'
    user.last_name = 'Phan'
    user.user_name = 'hapt'
    user.email = 'phanha9389facebook@gmail.com'
    user.save
    set_ommniauth_facebook
    get :create
    user1 = User.find_by('sns_accounts.provider' => 'facebook', 'sns_accounts.uid' => 'fb123545')
    assert_not user1.nil?
    assert_equal session["user_id"], user1.id
    assert_redirected_to student_index_path
  end

  # Description: sign up not successful with case: facebook account not exist, user_name exist, email not exist
  # @author: HaPT
  # Create Date: 29/10/2014
  # Modify Date:
  test "sign up not successful with username exist" do
    User.delete_all(user_name: 'haptfacebook')
    User.delete_all(email: 'phanha9389facebook@gmail.com')
    user = User.new
    user.first_name = 'Ha'
    user.last_name = 'Phan'
    user.user_name = 'haptfacebook'
    user.email = 'huyendt@telsoft.com.vn'
    user.save
    set_ommniauth_facebook
    get :create
    post :signup_sns, :user => {:first_name => 'Ha', :last_name => 'Phan', :user_name => 'haptfacebook',
                                :email => 'phanha93891@gmail.com', :sns_accounts_attributes => [:provider => 'facebook', :uid => 'fb123545', :user_name => 'haptfacebook',
                                                                                                :first_name => 'Phan', :last_name => 'Ha', :email => 'phanha9389facebook@gmail.com',
                                                                                                :image_url => 'http://', :access_token => '4328473824']}
    assert assigns(:user).errors[:user_name]
  end

  # Description: sign up not successful with case: twitter account not exist, email exist
  # @author: HaPT
  # Create Date: 29/10/2014
  # Modify Date:
  test "not successful with twitter not exist and email exist" do
    User.delete_all(email: 'phanha9389twitter@gmail.com')
    user = User.new
    user.first_name = 'Ha'
    user.last_name = 'Phan'
    user.user_name = 'haptfacebook'
    user.email = 'phanha9389twitter@gmail.com'
    user.save
    set_ommniauth_twitter
    get :create
    post :signup_sns, :user => {:first_name => 'Ha', :last_name => 'Phan', :user_name => 'hapt',
                                :email => 'phanha9389twitter@gmail.com', :sns_accounts_attributes => [:provider => 'twitter', :uid => 'tw123545', :user_name => 'hapttwitter',
                                                                                                      :first_name => '', :last_name => '', :email => '',
                                                                                                      :image_url => 'http://', :access_token => '4328473824']}
    assert assigns(:user).errors[:email]
  end

  # Description: sign in successful with case: google account exist
  # @author: HaPT
  # Create Date: 29/10/2014
  # Modify Date:
  test "sign in successful with sns exist" do
    set_ommniauth_google
    get :create
    user = User.find_by('sns_accounts.provider' => 'google', 'sns_accounts.uid' => 'gl123545')
    assert_not user.nil?
    assert_equal session["user_id"], user.id
    assert_redirected_to student_index_path
  end


  # Description: Definition facebook account to test
  def set_ommniauth_facebook(email = 'phanha9389facebook@gmail.com')
    OmniAuth.config.mock_auth[:facebook] = auth_hash_facebook(email)
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  def auth_hash_facebook(email)
    {
        'provider' => 'facebook',
        "info" => {
            'name'  => 'Omniauth-user',
            'email' => email,
            'user_name' => 'haptfacebook',
            'first_name' => 'Phan',
            'last_name' => 'Ha',
            'image' => 'http://'
        },
        'uid' => 'fb123545',
        'credentials' =>{
            'token' => '4328473824'
        }

    }
  end

  # Description: Definition google account to test
  def set_ommniauth_google(email = 'phanha9389google@gmail.com')
    OmniAuth.config.mock_auth[:google] = auth_hash_google(email)
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
  end

  def auth_hash_google(email)
    {
        'provider' => 'google',
        "info" => {
            'name'  => 'Omniauth-user',
            'email' => email,
            'user_name' => 'haptgoogle',
            'first_name' => 'Phan',
            'last_name' => 'Ha',
            'image' => 'http://'
        },
        'uid' => 'gl123545',
        'credentials' =>{
            'token' => '4328473824'
        }

    }
  end

  # Description: Definition twitter account to test
  def set_ommniauth_twitter(email = 'phanha9389twitter@gmail.com')
    OmniAuth.config.mock_auth[:twitter] = auth_hash_twitter(email)
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
  end

  def auth_hash_twitter(email)
    {
        'provider' => 'twitter',
        "info" => {
            'user_name' => 'hapttwitter',
            'image' => 'http://'
        },
        'uid' => 'tw1234567',
        'credentials' =>{
            'token' => '4328473824'
        }

    }
  end

end
