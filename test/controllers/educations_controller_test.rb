require 'test_helper'

class EducationsControllerTest < ActionController::TestCase
  # use jp_aes_test_huyendt

  # TDD list education
  # Description: list educations successful
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'list educations successful' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    get :index

    educations = assigns(:educations)

    expected_educations = Education.where(user_id: user.id).order_by(created_at: -1)

    assert_equal educations, expected_educations

  end

  # TDD create education
  # Description: create education successful
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'create education successful' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name'
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    education = assigns(:education)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)

    assert_equal education, expected_education
  end

  # Description: create education with school name is nil
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'create education with school name is nil' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = ''
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert_not_empty assigns(:education).errors[:school_name]
    puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education
  end

  # Description: create education with school name length is greater than 200
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'create education with school name length is greater than 200' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = ''

    for i in 1..201
      school_name = school_name + 'a'
    end
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert_not_empty assigns(:education).errors[:school_name]
    puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education
  end

  # Description: create education with school name with white space first and end
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'create education with school name with white space first and end' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = '   school name   '
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    education = assigns(:education)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)

    assert_equal education, expected_education
  end

  # Description: create education with start year is nil
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'create education with start year is nil' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = ''
    end_year = 2013
    school_name = 'abc'
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert_not_empty assigns(:education).errors[:start_year]
    puts(assigns(:education).errors.full_messages.to_sentence)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education

  end

  # Description: create education with start year is not number
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'create education with start year is not number' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 'abc'
    end_year = 2013
    school_name = 'abc'
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert_not_empty assigns(:education).errors[:start_year]
    puts(assigns(:education).errors.full_messages.to_sentence)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education

  end


  # Description: create education with start year is less than 1905
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'create education with start year is less than 1905' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 1900
    end_year = 2013
    school_name = 'abc'
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert_not_empty assigns(:education).errors[:start_year]
    puts(assigns(:education).errors.full_messages.to_sentence)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education

  end

  # Description: create education with start year is greater than now
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'create education with start year is greater than now' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2015
    end_year = 2013
    school_name = 'abc'
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert_not_empty assigns(:education).errors[:start_year]
    puts(assigns(:education).errors.full_messages.to_sentence)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education

  end

  # Description: create education with end year is not number
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'create education with end year is not number' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = '2000'
    end_year = 'abc'
    school_name = 'abc'
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert_not_empty assigns(:education).errors[:end_year]
    puts(assigns(:education).errors.full_messages.to_sentence)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education

  end

  # Description: create education with end year is less than 1905
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'create education with end year is less than 1905' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2000
    end_year = 1900
    school_name = 'abc'
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert_not_empty assigns(:education).errors[:end_year]
    puts(assigns(:education).errors.full_messages.to_sentence)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education

  end

  # Description: create education with end year is greater than now
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'create education with end year is greater than now' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2015
    school_name = 'abc'
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert_not_empty assigns(:education).errors[:end_year]
    puts(assigns(:education).errors.full_messages.to_sentence)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education

  end

  # Description: create education with end year is less than start year
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'create education with end year is less than start year' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2000
    school_name = 'abc'
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert_not_empty assigns(:education).errors[:end_year]
    puts(assigns(:education).errors.full_messages.to_sentence)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education
  end

  # Description: create education with description length is greater than 200
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'create education with description length is greater than 200' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'abc'
    description = ''
    for i in 1..201
      description = description + 'a'
    end

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert_not_empty assigns(:education).errors[:description]
    puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education
  end

  # Description: create education with description with white space first and end
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'create education with description with white space first and end' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name'
    description = '   description   '

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    education = assigns(:education)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)

    assert_equal education, expected_education
  end

  # Description: edit education successful
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'edit education successful' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name edit successful'
    description = 'description edit successful'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #education information
    edit_current = false
    edit_start_year = 2013
    edit_end_year = 2013
    edit_school_name = 'updated school name edit successful'
    edit_description = 'updated description edit successful'

    post :update, :id => education.id.to_s, :education => {:school_name => edit_school_name, :current => edit_current, :start_year => edit_start_year, :end_year => edit_end_year, :description => edit_description}, :format => 'js'

    education = assigns(:education)

    expected_education = Education.find_by(id: education.id.to_s)

    assert_equal education, expected_education
  end

  # Description: edit education not existed
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'edit education not existed' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name not existed'
    description = 'description not existed'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #education information
    edit_current = false
    edit_start_year = 2013
    edit_end_year = 2013
    edit_school_name = 'updated school name not existed'
    edit_description = 'updated description not existed'

    assert Education.delete_all(_id: education.id)

    post :update, :id => education.id.to_s, :education => {:school_name => edit_school_name, :current => edit_current, :start_year => edit_start_year, :end_year => edit_end_year, :description => edit_description}, :format => 'js'

    assert_equal flash.now[:error], I18n.t('educations.msg_education_not_found')
  end

  # Description: edit education with school name is nil
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'edit education with school name is nil' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name not existed'
    description = 'description not existed'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #education information
    edit_current = false
    edit_start_year = 2013
    edit_end_year = 2013
    edit_school_name = ''
    edit_description = 'updated description not existed'


    post :update, :id => education.id.to_s, :education => {:school_name => edit_school_name}, :format => 'js'
    assert_not_empty assigns(:education).errors[:school_name]
    puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(id: education.id)
    assert_not_equal expected_education.school_name, edit_school_name
  end

  # Description: edit education with school name length is greater than 200
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'edit education with school name length is greater than 200' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name not existed'
    description = 'description not existed'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #education information
    edit_current = false
    edit_start_year = 2013
    edit_end_year = 2013
    edit_school_name = ''

    for i in 1..201
      edit_school_name = edit_school_name + 'a'
    end
    edit_description = 'updated description '


    post :update, :id => education.id.to_s, :education => {:school_name => edit_school_name}, :format => 'js'
    assert_not_empty assigns(:education).errors[:school_name]
    puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(id: education.id)
    assert_not_equal expected_education.school_name, edit_school_name
  end

  # Description: edit education with school name with white space first and end
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'edit education with school name with white space first and end' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name'
    description = 'description'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #education information
    edit_current = false
    edit_start_year = 2013
    edit_end_year = 2013
    edit_school_name = '   updated school name     '

    edit_description = 'updated description'


    post :update, :id => education.id.to_s, :education => {:school_name => edit_school_name}, :format => 'js'
    # assert_not_empty assigns(:education).errors[:school_name]
    # puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(id: education.id)
    assert_equal expected_education.school_name, edit_school_name.strip
  end

  # Description: edit education with start year is nil
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'edit education with start year is nil' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name not existed'
    description = 'description not existed'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #education information
    edit_current = false
    edit_start_year = ''
    edit_end_year = 2013
    edit_school_name = 'updated school name'
    edit_description = 'updated description'


    post :update, :id => education.id.to_s, :education => {:start_year => edit_start_year}, :format => 'js'
    assert_not_empty assigns(:education).errors[:start_year]
    puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(id: education.id)
    assert_not_equal expected_education.start_year, edit_start_year
  end

  # Description: edit education with start year is not number
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'edit education with start year is not number' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name'
    description = 'description'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #education information
    edit_current = false
    edit_start_year = 'abc'
    edit_end_year = 2013
    edit_school_name = 'updated school name'
    edit_description = 'updated description'


    post :update, :id => education.id.to_s, :education => {:start_year => edit_start_year}, :format => 'js'
    assert_not_empty assigns(:education).errors[:start_year]
    puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(id: education.id)
    assert_not_equal expected_education.start_year, edit_start_year
  end

  # Description: edit education with start year is less than 1905
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'edit education with start year is less than 1905' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name'
    description = 'description'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #education information
    edit_current = false
    edit_start_year = 1904
    edit_end_year = 2013
    edit_school_name = 'updated school name'
    edit_description = 'updated description'


    post :update, :id => education.id.to_s, :education => {:start_year => edit_start_year}, :format => 'js'
    assert_not_empty assigns(:education).errors[:start_year]
    puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(id: education.id)
    assert_not_equal expected_education.start_year, edit_start_year
  end

  # Description: edit education with start year is greater than now
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'edit education with start year is greater than now' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name'
    description = 'description'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #education information
    edit_current = false
    edit_start_year = Time.now.year + 1
    edit_end_year = 2013
    edit_school_name = 'updated school name'
    edit_description = 'updated description'


    post :update, :id => education.id.to_s, :education => {:start_year => edit_start_year}, :format => 'js'
    assert_not_empty assigns(:education).errors[:start_year]
    puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(id: education.id)
    assert_not_equal expected_education.start_year, edit_start_year
  end

  # Description: edit education with end year is not number
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'edit education with end year is not number' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name'
    description = 'description'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #education information
    edit_current = false
    edit_start_year = 2013
    edit_end_year = 'abc'
    edit_school_name = 'updated school name'
    edit_description = 'updated description'


    post :update, :id => education.id.to_s, :education => {:end_year => edit_end_year}, :format => 'js'
    assert_not_empty assigns(:education).errors[:end_year]
    puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(id: education.id)
    assert_not_equal expected_education.end_year, edit_end_year
  end

  # Description: edit education with end year is less than 1905
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'edit education with end year is less than 1905' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name'
    description = 'description'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #education information
    edit_current = false
    edit_start_year = 2013
    edit_end_year = 1904
    edit_school_name = 'updated school name'
    edit_description = 'updated description'


    post :update, :id => education.id.to_s, :education => {:end_year => edit_end_year}, :format => 'js'
    assert_not_empty assigns(:education).errors[:end_year]
    puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(id: education.id)
    assert_not_equal expected_education.end_year, edit_end_year
  end

  # Description: edit education with end year is greater than now
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'edit education with end year is greater than now' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name'
    description = 'description'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #education information
    edit_current = false
    edit_start_year = 2013
    edit_end_year = Time.now.year + 1
    edit_school_name = 'updated school name'
    edit_description = 'updated description'


    post :update, :id => education.id.to_s, :education => {:end_year => edit_end_year}, :format => 'js'
    assert_not_empty assigns(:education).errors[:end_year]
    puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(id: education.id)
    assert_not_equal expected_education.end_year, edit_end_year
  end

  # Description: edit education with end year is less than start year
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'edit education with end year is less than start year' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name'
    description = 'description'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #education information
    edit_current = false
    edit_start_year = 2013
    edit_end_year = 2012
    edit_school_name = 'updated school name'
    edit_description = 'updated description'


    post :update, :id => education.id.to_s, :education => {:end_year => edit_end_year}, :format => 'js'
    assert_not_empty assigns(:education).errors[:end_year]
    puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(id: education.id)
    assert_not_equal expected_education.end_year, edit_end_year
  end

  # Description: edit education with description length is greater than 200
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'edit education with description length is greater than 200' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name'
    description = 'description'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #education information
    edit_current = false
    edit_start_year = 2013
    edit_end_year = 2012
    edit_school_name = 'updated school name'
    edit_description = ''
    for i in 1..201
      edit_description = edit_description + 'a'
    end

    post :update, :id => education.id.to_s, :education => {:description => edit_description}, :format => 'js'
    assert_not_empty assigns(:education).errors[:description]
    puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(id: education.id)
    assert_not_equal expected_education.description, edit_description
  end


  # Description: edit education with description with white space first and end
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'edit education with description with white space first and end' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name'
    description = 'description'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #education information
    edit_current = false
    edit_start_year = 2013
    edit_end_year = 2013
    edit_school_name = 'updated school name'

    edit_description = '       updated description           '


    post :update, :id => education.id.to_s, :education => {:description => edit_description}, :format => 'js'
    # assert_not_empty assigns(:education).errors[:school_name]
    # puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(id: education.id)
    assert_equal expected_education.description, edit_description.strip
  end



  # Description:delete education successful
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'delete education successful' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name'
    description = 'description'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    delete :destroy, :id => education.id, :format => 'js'

    assert_nil Education.find_by(id: education.id)
  end


  # Description:delete education not existed
  # @author: HuyenDT
  # Create Date: 23/12/2014
  # Modify Date:
  test 'delete education not existed' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name'

    description = 'description'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #delete data
    assert Education.delete_all(_id: education.id)

    delete :destroy, :id => education.id, :format => 'js'

    assert_equal flash.now[:error], I18n.t('educations.msg_education_not_found')
  end
end