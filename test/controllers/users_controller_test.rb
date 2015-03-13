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
                                                       birth_day: '1991-04-09', phone_number: '096-807-2568', address: 'quang ninh', city: 'cam pha', country: country
    }, format: :js
    # assert_response 's'
    puts ((assert flash[:now]) ? "Passed -------- " : "Failed -------- ").to_s + __method__.to_s

  end

  test 'update user basic information empty birth_day' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', first_name: 'cao', last_name: 'the cuong', gender: 1,
                                                       birth_day: '', phone_number: '096-807-2568', address: 'quang ninh', city: 'cam pha', country: country
                              }, format: :js
    # assert_response 's'
    puts ((assert flash[:now]) ? "Passed -------- " : "Failed -------- ").to_s + __method__.to_s
  end

  test 'update user basic information phone_number' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', first_name: 'cao', last_name: 'the cuong', gender: 1,
                                                       birth_day: '1991-04-09', phone_number: '', address: 'quang ninh', city: 'cam pha', country: country
                              }, format: :js
    # assert_response 's'
    puts ((assert flash[:now]) ? "Passed -------- " : "Failed -------- ").to_s + __method__.to_s
  end

  test 'update user basic information empty address' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', first_name: 'cao', last_name: 'the cuong', gender: 1,
                                                       birth_day: '1991-04-09', phone_number: '096-807-2568', address: '', city: 'cam pha', country: country
                              }, format: :js
    # assert_response 's'
    puts ((assert flash[:now]) ? "Passed -------- " : "Failed -------- ").to_s + __method__.to_s
  end

  test 'update user basic information empty city' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', first_name: 'cao', last_name: 'the cuong', gender: 1,
                                                       birth_day: '1991-04-09', phone_number: '096-807-2568', address: 'quang ninh', city: '', country: country
                              }, format: :js
    # assert_response 's'
    puts ((assert flash[:now]) ? "Passed -------- " : "Failed -------- ").to_s + __method__.to_s
  end

  test 'update user basic information country' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = nil
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', first_name: 'cao', last_name: 'the cuong', gender: 1,
                                                       birth_day: '1991-04-09', phone_number: '096-8072568', address: 'quang ninh', city: 'cam pha', country: country
                              }, format: :js
    # assert_response 's'
    puts ((assert flash[:now]) ? "Passed -------- " : "Failed -------- ").to_s + __method__.to_s
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
    puts ((assert flash[:error]) ? "Passed -------- " : "Failed -------- ").to_s + __method__.to_s
  end

  test 'update user basic information empty email' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    patch :update_user_profile,id: user.id, :user => {email:'', first_name: 'cao', last_name: 'the cuong', gender: 1,
                                  birth_day: '1991-04-09', phone_number: '096-807-2568', address: 'quang ninh', city: 'cam pha', country: country
                              }, format: :js
    # assert_response 's'
    puts ((assert flash[:error]) ? "Passed -------- " : "Failed -------- ").to_s + __method__.to_s
  end

  test 'update user basic information empty first_name' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn',first_name: '', last_name: 'the cuong', gender: 1,
                                                       birth_day: '1991-04-09', phone_number: '096-807-2568', address: 'quang ninh', city: 'cam pha', country: country
                              }, format: :js
    # assert_response 's'
    puts ((assert flash[:error]) ? "Passed -------- " : "Failed -------- ").to_s + __method__.to_s
  end

  test 'update user basic information empty last_name' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', first_name: 'cao', last_name: '',  gender: 1,
                                                       birth_day: '1991-04-09', phone_number: '096-807-2568', address: 'quang ninh', city: 'cam pha', country: country
                              }, format: :js
    # assert_response 's'
    puts ((assert flash[:error]) ? "Passed -------- " : "Failed -------- ").to_s + __method__.to_s
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
                                  birth_day: '1991-04-09', phone_number: '096-807-2568', address: 'quang ninh', city: 'cam pha', country: country
                              }, format: :js
    # assert_response 's'
    puts ((assert flash[:error]) ? "Passed -------- " : "Failed -------- ").to_s + __method__.to_s
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
                                                       birth_day: '1991-04-09', phone_number: '096-807-2568', address: 'quang ninh', city: 'cam pha', country: country
                              }, format: :js
    # assert_response 's'
    puts ((assert flash[:error]) ? "Passed -------- " : "Failed -------- ").to_s + __method__.to_s
  end

  test 'update user basic information maxlength first_name' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    name = ''
    for i in  1..200 do
      name+='i'
    end
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', first_name: name, last_name: 'the cuong', gender: 1,
                                                       birth_day: '1991-04-09', phone_number: '096-807-2568', address: 'quang ninh', city: 'cam pha', country: country
                              }, format: :js
    puts ((assert flash[:error]) ? "Passed -------- " : "Failed -------- ").to_s + __method__.to_s
  end

  test 'update user basic information maxlength last_name' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    name = ''
    for i in  1..200 do
      name+='i'
    end
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', first_name: 'cao', last_name: name,  gender: 1,
                                                       birth_day: '1991-04-09', phone_number: '096-807-2568', address: 'quang ninh', city: 'cam pha', country: country
                              }, format: :js
    puts ((assert flash[:error]) ? "Passed -------- " : "Failed -------- ").to_s + __method__.to_s
  end

  test 'update user basic information maxlength phone_number' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    maxlength = ''
    for i in  1..200 do
      maxlength+='i'
    end
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', first_name: 'cao', last_name: 'name',  gender: 1,
                                                       birth_day: '1991-04-09', phone_number: maxlength, address: 'quang ninh', city: 'cam pha', country: country
                              }, format: :js
    puts ((assert flash[:error]) ? "Passed -------- " : "Failed -------- ").to_s + __method__.to_s
  end

  test 'update user basic information maxlength address' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    maxlength = ''
    for i in  1..200 do
      maxlength+='i'
    end
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', first_name: 'cao', last_name: 'name',  gender: 1,
                                                       birth_day: '1991-04-09', phone_number: '096-807-2568', address: maxlength, city: 'cam pha', country: country
                              }, format: :js
    puts ((assert flash[:error]) ? "Passed -------- " : "Failed -------- ").to_s + __method__.to_s
  end

  test 'update user basic information maxlength city' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    maxlength = ''
    for i in  1..200 do
      maxlength+='i'
    end
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', first_name: 'cao', last_name: 'name',  gender: 1,
                                                       birth_day: '1991-04-09', phone_number: '096-807-2568', address: 'quang ninh', city: maxlength, country: country
                              }, format: :js
    puts ((assert flash[:error]) ? "Passed -------- " : "Failed -------- ").to_s + __method__.to_s
  end

#==================================== FORMAT                       ========================
  test 'update user basic information email format' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    patch :update_user_profile,id: user.id, :user => { email: 'cuonggggg', first_name: 'cao', last_name: name,  gender: 1,
                                                       birth_day: '1991-04-09', phone_number: '096-807-2568', address: 'quang ninh', city: 'cam pha', country: country
                              }, format: :js
    # assert flash[:error]
    puts ((assert flash[:error]) ? "Passed -------- " : "Failed -------- ").to_s + __method__.to_s
  end

  test 'update user basic information phone format' do
    user = User.find_by(user_name: 'cuongct')
    session[:user_id] = user.id
    # get :edit, curriculum
    country = Country.first.id
    patch :update_user_profile,id: user.id, :user => { email: 'cuongct@telsoft.com.vn', first_name: 'cao', last_name: name,  gender: 1,
                                                       birth_day: '1991-04-09', phone_number: '096-807-2561', address: 'quang ninh', city: 'cam pha', country: country
                              }, format: :js
    assert flash[:error]
    puts flash[:error]
  end

end
