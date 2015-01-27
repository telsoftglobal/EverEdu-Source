require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "create_user_successful" do
    #delete user
    User.delete_all(user_name: 'cant')

    #insert user
    user = User.new
    user.first_name = 'Ca'
    user.last_name = 'Nguyen'
    user.user_name = 'cant'
    user.email = 'cant@telsoft.com.vn'
    user.avatar_url = 'http://'
    user.password = '123456'

    assert user.save
  end


  test "create_user_duplicate_user_name" do
    #insert user
    user = User.new
    user.first_name = 'Ca'
    user.last_name = 'Nguyen'
    user.user_name = 'cant'
    user.email = 'cant@telsoft.com.vn'
    user.avatar_url = 'http://'
    user.password = '123456'

    assert_not user.save
    user.errors.full_messages.each do |message|
      puts message
    end
  end


  test "create_user_duplicate_email" do
    #insert user
    user = User.new
    user.first_name = 'Ca'
    user.last_name = 'Nguyen'
    user.user_name = 'cant'
    user.email = 'cant@telsoft.com.vn'
    user.avatar_url = 'http://'
    user.password = '123456'

    assert_not user.save
    user.errors.full_messages.each do |message|
      puts message
    end
  end


  test "insert_user" do
    user = User.new
    user.first_name = 'Huyen'
    user.last_name = 'Duong'
    user.user_name = 'huyendt'
    user.email = 'huyendt@telsoft.com.vn'
    user.avatar_url = 'http://'
    user.status = 1
    user.password = '123456'

    begin
      user.save
    rescue Moped::Errors::OperationFailure => e
      puts e.message
      #puts e.backtrace
    end
  end

  test "insert_user_duplicate_user_name" do
    user = User.new
    user.first_name = 'Huyen'
    user.last_name = 'Duong'
    user.user_name = 'huyendt'
    user.email = 'huyendt@telsoft.com.vn'
    user.avatar_url = 'http://'
    user.status = 1
    user.password = '123456'

    begin
      user.save
    rescue Exception => e
      puts e.message
    end
  end

  test "edit_user" do
    user = User.where(user_name: 'huyendt').first
    user.last_name = 'Duong thu'
    user.save
  end


  test "insert_user_with_profile" do
    #delete user
    User.delete_all(user_name: 'cant')

    #insert user
    user = User.new
    user.first_name = 'Ca'
    user.last_name = 'Nguyen'
    user.user_name = 'cant'
    user.email = 'cant@telsoft.com.vn'
    user.avatar_url = 'http://'
    user.status = 1
    user.password = '123456'

    user.save

    user.create_user_profile
  end

  test "insert_user_with_default_role" do
    #delete user
    User.delete_all(user_name: 'cant')

    #insert user
    user = User.new
    user.first_name = 'Ca'
    user.last_name = 'Nguyen'
    user.user_name = 'cant'
    user.email = 'cant@telsoft.com.vn'
    user.avatar_url = 'http://'
    user.status = 1
    user.password = '123456'
    user.roles = [Role.get_role_default]

    user.save
  end

  test "insert_user_with_mentor_role" do
    #delete user
    User.delete_all(user_name: 'huyendt')

    #insert user
    user = User.new
    user.first_name = 'Huyen'
    user.last_name = 'Duong'
    user.user_name = 'huyendt'
    user.email = 'huyendt@telsoft.com.vn'
    user.avatar_url = 'http://'
    user.status = 1
    user.password = '123456'
    user.roles = [Role.find_by(name: 'Mentor')]

    user.save
  end

  test "insert_user_with_sns_account" do
    #delete user
    User.delete_all(user_name: 'cant')

    #insert user
    user = User.new
    user.first_name = 'Ca'
    user.last_name = 'Nguyen'
    user.user_name = 'cant'
    user.email = 'cant@telsoft.com.vn'
    user.avatar_url = 'http://'
    user.status = 1
    user.password = '123456'
    user.roles = [Role.get_role_default]

    sns_account = SnsAccount.new(provider: 'facebook', uid: '123456', user_name: 'cant')
    user.sns_accounts = [sns_account]
    user.save
  end

  test "insert_user_full" do
    #delete user
    User.delete_all(user_name: 'cant')

    #insert user
    user = User.new
    user.first_name = 'Ca'
    user.last_name = 'Nguyen'
    user.user_name = 'cant'
    user.email = 'cant@telsoft.com.vn'
    user.avatar_url = 'http://'
    user.status = 1
    user.password = '123456'

    #insert defalt role
    user.roles = [Role.get_role_default]

    #insert account
    sns_account = SnsAccount.new(provider: 'facebook', uid: '123456', user_name: 'cant')
    user.sns_accounts = [sns_account]
    user.save

    #insert user profile
    #user.create_user_profile
  end

  test "insert_user_full cuongct" do
    #delete user
    User.delete_all(user_name: 'cuongct')

    #insert user
    user = User.new
    user.first_name = 'Cuong'
    user.last_name = 'Cao The'
    user.user_name = 'cuongct'
    user.email = 'cuongct@telsoft.com.vn'
    user.avatar_url = 'http://'
    user.status = 1
    user.password = '123456'

    #insert defalt role
    user.roles = [Role.get_role_default]

    #insert account
    #sns_account = SnsAccount.new(provider: 'facebook', uid: '123456', user_name: 'cant')
    #user.sns_accounts = [sns_account]
    user.save

    #insert user profile
    #user.create_user_profile
  end


  test 'update_sns_account' do
    user = User.where(name: 'cant').first
    user.sns_accounts
  end

  test 'find_user_by_provider_uid' do
    user = User.find_by_provider_uid('facebook', '123456')
    if user.nil?
      puts "user is nil"
    else
      puts user
    end
  end

  test 'find_sns_account' do
    user = User.where(user_name: 'cant').first
    puts user.sns_accounts[0].provider
    puts user.sns_accounts[0].uid
    sns_account = user.sns_accounts.where('provider' => 'facebook', 'uid'=> '123456').first
    sns_account.update_attributes('user_name'=> "2344534")
    puts sns_account
  end

  test 'insert_user_with_duplicate_info' do
    user = User.new
    user.first_name = 'Huyen'
    user.last_name = 'Duong'
    user.user_name = 'huyendt'
    user.email = 'huyendt@telsoft.com.vn'
    user.avatar_url = 'http://'
    user.status = 1
    user.password = '123456'
    begin
      user.save
    rescue Moped::Errors::OperationFailure => e
      if e.message =~ /^11000/
        raise Exception 'ERROR_DUPLICATE_USER_INFO'
      end
    rescue Exception
      raise Exception 'ERROR_DATABASE'
    end
  end

  test "create_facebook_sns_with_email_exist" do

    #init sns account with email exist: huyendt@telsoft.com.vn
    snsAccount = SnsAccount.new
    snsAccount.provider = 'facebook'
    snsAccount.uid = '123456'
    snsAccount.user_name = 'huyendt'
    snsAccount.email = 'huyendt@telsoft.com.vn'

    user = User.where(email: snsAccount.email).first
    if user.blank?
      puts "user doesn't exist"
    else
      assert user.sns_accounts.push(snsAccount)
    end
  end


  test "create_google_sns_with_email_exist" do
    #init sns account with email exist: huyendt@telsoft.com.vn
    snsAccount = SnsAccount.new
    snsAccount.provider = 'google'
    snsAccount.uid = '123456'
    snsAccount.user_name = 'huyendt'
    snsAccount.email = 'huyendt@telsoft.com.vn'

    user = User.where(email: snsAccount.email).first
    if user.blank?
      puts "user doesn't exist"
    else
      assert user.sns_accounts.push(snsAccount)
    end
  end

  test "update_facebook_sns_exist" do
    #init sns account with email exist: huyendt@telsoft.com.vn
    snsAccount = SnsAccount.new
    snsAccount.provider = 'facebook'
    snsAccount.uid = '123456'
    snsAccount.user_name = 'huyendt1'
    snsAccount.email = 'huyendt@telsoft.com.vn'
    snsAccount.first_name = 'Huyen'

    #find user with provider, uid
    user = User.where('sns_accounts.provider' => snsAccount.provider, 'sns_accounts.uid' => snsAccount.uid).first
    if user.blank?
      puts "user doesn't exist"
    else
      sns_account_exist = user.sns_accounts.where('provider' => snsAccount.provider, 'uid'=> snsAccount.uid).first
      sns_account_exist.first_name = snsAccount.first_name
      #assert sns_account_exist.update_attributes('user_name' => snsAccount.user_name)
      assert user.save
    end
  end


  test "find_not_found_user" do
    user = User.find_by(user_name: 'cant')
  end

  test "find_provider_uid" do
    user = User.find_by("sns_accounts.provider" => "123", "sns_accounts.uid" => "123")
  end

  test "delete_user_by_username" do
    assert User.delete_all(user_name: 'huyendt')
  end

  test "authenticate" do
    assert_not_nil User.authenticate('cant@telsoft.com.vn', '123456')
  end

  test "user_has_role" do
    user = User.find_by(user_name: 'huyendt')
    has_role = false
    if !user.roles.nil?
      user.roles.each do |role|
        if role.name.eql?'Mentor'
          has_role = true
        end
      end
    end

    assert has_role
  end



  test "print_const_role" do
    puts Role::ROLE_DEFAULT
  end

  # this method test update time when save new user
  test "update_time_when_save_new_user" do

    User.delete_all(user_name: 'user1')

    user = User.new
    user.first_name = 'Ca'
    user.last_name = 'Nguyen'
    user.user_name = 'user1'
    user.email = 'user1@telsoft.com.vn'
    user.avatar_url = 'http://'
    user.status = 1
    user.password = '123456'
    user.roles = [Role.get_role_default]

    sns_account = SnsAccount.new(provider: 'facebook', uid: '123456', user_name: 'cant')
    user.sns_accounts = [sns_account]
    assert user.save

    user = User.find_by(user_name: 'user1')
    assert_not user.nil?
    assert_not user.updated_at.nil?
  end

  # this method test update time when create new user
  test "update_time_when_create_user" do
    User.delete_all(user_name: 'user1')

    User.create(first_name: 'Ca', last_name: 'Nguyen', user_name: 'user1')

    user = User.find_by(user_name: 'user1')
    assert_not user.nil?
    assert_not user.updated_at.nil?
  end

  # this method test update time when save exist user
  test "update_time_when_save_exist_user" do
    user = User.find_by(user_name: 'user1')
    old_updated_time = user.updated_at

    user.email = 'user1@telsoft.com'
    assert user.save
    assert_not_equal old_updated_time, user.updated_at
  end

  test "update_time_when_push_sns_account_to_user" do
    user = User.find_by(user_name: 'user1')
    old_updated_time = user.updated_at

    assert user.sns_accounts.push(SnsAccount.new(provider: 'facebook', uid: '123456', user_name: 'user1'))
    assert user.save
    assert_not_equal old_updated_time, user.updated_at
  end

  test "update_time_when_update_sns_account_to_user" do
    user = User.find_by(user_name: 'user1')

    sns_account_exist = user.sns_accounts.find_by('provider'=> 'facebook', 'uid' => '123454')
    assert sns_account_exist.update_attributes('user_name' => 'user123', 'first_name' => '1234')
  end

  test "update_time_when_update_sns_account_use_save_user" do
    user = User.find_by(user_name: 'user1')

    sns_account_exist = user.sns_accounts.find_by('provider'=> 'facebook', 'uid' => '123454')
    sns_account_exist.last_name = '123456'

    sns_account = SnsAccount.new('provider'=> 'google', 'uid' => '123454')
    size = user.sns_accounts.size
    user.sns_accounts[size] = sns_account
    assert user.save
  end

  test "find user name case insensitive" do
    email = 'SONNH@gmail.com'
    user = User.find_by(email: /^#{email}$/i)
    assert_not user.nil?
  end

  test "count unread notification" do
    user = User.find_by(user_name: 'huyendt')
    puts user.count_unread_notification(Notification::COMMENT_TYPE, "547d5c5b48757914c7440000", "Material")
  end

  test "read all notification" do
    user = User.find_by(user_name: 'huyendt')
    user.read_all_notification(Notification::COMMENT_TYPE, "547d5c5b48757914c7440000", "Material")
    assert_equal user.count_unread_notification(Notification::COMMENT_TYPE, "547d5c5b48757914c7440000", "Material"), 0
  end

  test "dfsd" do
    user = User.find_by(:id => BSON::ObjectId.from_string('5466c2f443756f156c000000'))
    user.update_attribute(:hashed_password, User.encrypt_password('123456', user.salt))
    puts User.encrypt_password('123456', user.salt)

  end

end
