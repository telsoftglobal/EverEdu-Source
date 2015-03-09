require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get signin" do
    get :signin
    assert_response :success
  end

  test "signin successful role mentor" do
    #precondition: email: huyendt@telsoft.com.vn, password: 123456, role = Mentor
    # user with this email and password is existing
    email = "huyendt@telsoft.com.vn"
    password = "123456"

    post :signin, :email => email, :password => password
    user = User.find_by(email: email)
    assert_not user.nil?
    assert_equal session["user_id"], user.id
    assert_redirected_to mentor_index_path
  end

  test "signin successful role student" do
    #precondition: email: cant@telsoft.com.vn, password: 123456, role = Student
    # user with this email and password is existing
    email = "cant@telsoft.com.vn"
    password = "123456"

    post :signin, :email => email, :password => password
    user = User.find_by(email: email)
    assert_not user.nil?
    assert_equal session["user_id"], user.id
    assert_redirected_to student_index_path
  end

  test "signin_fail_with_password_wrong" do
    #precondition: email: huyendt@telsoft.com.vn, password: 1234567, role = Student
    # user with this email is exist

    email = "huyendt@telsoft.com.vn"
    password = "1234567"

    post :signin, :email => email, :password => password
    user = User.find_by(email: email)

    assert_not user.nil?
    assert_not_equal session["user_id"], user.id
    assert_equal assigns(:message), I18n.t('signin.msg_signup_fail')
    #assert_redirected_to student_index_path
  end

  test "signin_fail_with_email_not_exist" do
    #precondition: email: huyendt1@telsoft.com.vn, password: 1234567, role = Student
    # this email isn't exist

    email = "huyendt1@telsoft.com.vn"
    password = "1234567"

    post :signin, :email => email, :password => password
    user = User.find_by(email: email)

    assert user.nil?
    assert_equal assigns(:message), I18n.t('signin.msg_signup_fail')
    #assert_redirected_to student_index_path
  end

  test "should get signup" do
    get :signup
    assert_response :success
  end

  test "should post signup successful" do
    #init test delete user with user_name = huyendt and email = 'huyendt@telsoft.com.vn'
    User.delete_all(user_name: 'huyendt')
    User.delete_all(email: 'huyendt@telsoft.com.vn')

    #request post signup
    post :signup, :user => {:first_name => 'Huyen', :last_name => 'Duong', :user_name => 'huyendt', :email => 'huyendt@telsoft.com.vn', :password => '123456'}
    user = User.find_by(user_name: 'huyendt')
    assert_not user.nil?
    assert_equal session["user_id"], user.id
    assert_redirected_to student_index_path
  end

  test "should post signup with existing user name" do
    #user_name = huyendt and email = 'huyendt1@telsoft.com.vn'

    #request post signup
    post :signup, :user => {:first_name => 'Huyen', :last_name => 'Duong', :user_name => 'huyendt', :email => 'huyendt1@telsoft.com.vn', :password => '123456'}
    user = User.find_by(email: 'huyendt1@telsoft.com.vn')
    assert_nil user
    assert assigns(:user).errors[:user_name]
  end

  test "should post signup with existing email" do
    #user_name = huyendt1 and email = 'huyendt@telsoft.com.vn'

    #request post signup
    post :signup, :user => {:first_name => 'Huyen', :last_name => 'Duong', :user_name => 'huyendt1', :email => 'huyendt@telsoft.com.vn', :password => '123456'}
    user = User.find_by(user_name: 'huyendt1')
    assert_nil user
    assert assigns(:user).errors[:email]
  end

  test "should post signup with existing email and user" do
    #user_name = huyendt and email = 'huyendt@telsoft.com.vn'

    #request post signup
    post :signup, :user => {:first_name => 'Huyen', :last_name => 'Duong', :user_name => 'huyendt', :email => 'huyendt@telsoft.com.vn', :password => '123456'}
    assert assigns(:user).errors[:email]
    assert assigns(:user).errors[:user]
  end


  test "should get signout" do
    get :signout
    assert_response :success
  end

end
