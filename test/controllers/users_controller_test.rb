require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # test "should get about" do
  #   get :about
  #   assert_response :success
  # end
  #
  # test "should get show" do
  #   get :show
  #   assert_response :success
  # end
#                                                 CuongCT
#==================================== UPDATE USER BASIC INFORMATION========================
#==================================== UPDATE SUCCESS               ========================
  test 'update user basic information full' do


    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', first_name: 'cao', last_name: 'the cuong', gender: 1,
                                                       birthday: '1991-04-09', phone: '0968072568', address: 'quang ninh', country: country
    }, format: :js
    # assert_response 's'
    assert flash[:now]
    puts flash[:now]

  end

  test 'update user basic information' do


    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', first_name: 'cao', last_name: 'the cuong', gender: 1
                              }, format: :js
    # assert_response 's'
    assert flash[:now]
    puts flash[:now]
  end

#==================================== UPDATE FAILED               ========================
#==================================== EMPTY                       ========================
  test 'update user basic information empty all' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    patch :update_user_profile,id: user.id, :user => {
                              }, format: :js
    # assert_response 's'
    assert flash[:error]
    puts flash[:error]
  end

  test 'update user basic information empty email' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    patch :update_user_profile,id: user.id, :user => { first_name: 'cao', last_name: 'the cuong', gender: 1,
                                  birthday: '1991-04-09', phone: '0968072568', address: 'quang ninh', country: country
                              }, format: :js
    # assert_response 's'
    assert flash[:error]
    puts flash[:error]
  end

  test 'update user basic information empty first_name' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', last_name: 'the cuong', gender: 1,
                                                       birthday: '1991-04-09', phone: '0968072568', address: 'quang ninh', country: country
                              }, format: :js
    # assert_response 's'
    assert flash[:error]
    puts flash[:error]
  end

  test 'update user basic information empty last_name' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', first_name: 'cao',  gender: 1,
                                                       birthday: '1991-04-09', phone: '0968072568', address: 'quang ninh', country: country
                              }, format: :js
    # assert_response 's'
    assert flash[:error]
    puts flash[:error]
  end
  #==================================== MAXLENGTH                       ========================


  test 'update user basic information maxlength all' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    email = ''
    name = ''
    for i in  1..200 do
      email+='i'
      name+='i'
    end
    patch :update_user_profile,id: user.id, :user => {
                                  email: email+'cuongct@telsoft.com.vn', first_name: name+'cao', last_name: name+'the cuong', gender: 1,
                                  birthday: '1991-04-09', phone: '0968072568', address: 'quang ninh', country: country
                              }, format: :js
    # assert_response 's'
    assert flash[:error]
    puts flash[:error]
  end

  test 'update user basic information maxlength email' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    email = ''
    name = ''
    for i in  1..200 do
      email+='i'
      name+='i'
    end
    patch :update_user_profile,id: user.id, :user => { email: email + 'cuongct@telsoft.com.vn', first_name: 'cao', last_name: 'the cuong', gender: 1,
                                                       birthday: '1991-04-09', phone: '0968072568', address: 'quang ninh', country: country
                              }, format: :js
    # assert_response 's'
    assert flash[:error]
    puts flash[:error]
  end

  test 'update user basic information maxlength first_name' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    email = ''
    name = ''
    for i in  1..200 do
      email+='i'
      name+='i'
    end
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', first_name: name, last_name: 'the cuong', gender: 1,
                                                       birthday: '1991-04-09', phone: '0968072568', address: 'quang ninh', country: country
                              }, format: :js
    assert flash[:error]
    puts flash[:error]
  end

  test 'update user basic information maxlength last_name' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', first_name: 'cao', last_name: name,  gender: 1,
                                                       birthday: '1991-04-09', phone: '0968072568', address: 'quang ninh', country: country
                              }, format: :js
    assert flash[:error]
    puts flash[:error]
  end

#==================================== FORMAT                       ========================
  test 'update user basic information email format' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    patch :update_user_profile,id: user.id, :user => { email: 'cuonggggg', first_name: 'cao', last_name: name,  gender: 1,
                                                       birthday: '1991-04-09', phone: '0968072568', address: 'quang ninh', country: country
                              }, format: :js
    assert flash[:error]
    puts flash[:error]
  end

  # test 'update user basic information phone format' do
  #   user = User.find_by(user_name: 'cuongct')
  #   session[:user_id] = user.id
  #   # get :edit, curriculum
  #   country = Country.first.id
  #   patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', first_name: 'cao', last_name: name,  gender: 1,
  #                                                      birthday: '1991-04-09', phone: '0968072568', address: 'quang ninh', country: country
  #                             }, format: :js
  #   assert flash[:error]
  #   puts flash[:error]
  # end

end
