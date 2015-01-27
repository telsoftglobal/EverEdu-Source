require 'test_helper'

class WorkExperiencesControllerTest < ActionController::TestCase
  # use jp_aes_test_huyendt

  # TDD list work experiences

  # Description: list work experiences successful
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'list work experiences successful' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    get :index

    work_experiences = assigns(:work_experiences)

    expected_work_experiences = WorkExperience.where(user_id: user.id).order_by(created_at: -1)

    assert_equal work_experiences, expected_work_experiences

  end


  # TDD create work experiences
  # Description: create work experiences successful
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'create work experiences successful' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    work_experience = assigns(:work_experience)

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)

    assert_equal work_experience, expected_work_experience

  end

  # TDD create work experiences
  # Description: create work experiences with category is nil
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'create work experiences with category is nil' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = nil
    level_id = nil

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:category]
    assert_not_empty assigns(:work_experience).errors[:level]

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience
  end

  # TDD create work experiences
  # Description: create work experience with level is nil
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'create work experience with level is nil' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = nil

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:level]

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience
  end

  # TDD create work experiences
  # Description: create work experience with start year is nil
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'create work experience with start year is nil' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = ''
    end_year = 2013
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:start_year]
    puts (assigns(:work_experience).errors[:start_year])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience

  end

  # TDD create work experiences
  # Description: create work experience with start year is not number
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'create work experience with start year is not number' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id
    level_id = Level.find_by(category_id: category_id, level_order: 1).id

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 'abc'
    end_year = 2013
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all(), :format => 'js'

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}

    assert_not_empty assigns(:work_experience).errors[:start_year]
    puts (assigns(:work_experience).errors[:start_year])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience

  end

  # TDD create work experiences
  # Description: create work experiences with start year is less than 1905
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'create work experiences with start year is less than 1905' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = '1900'
    end_year = 2013
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:start_year]
    puts (assigns(:work_experience).errors[:start_year])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience

  end

  # TDD create work experiences
  # Description: create work experiences with start year is greater than now
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'create work experiences with start year is greater than now' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = Time.now.year + 1
    end_year = 2013
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:start_year]
    puts (assigns(:work_experience).errors[:start_year])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience
  end

  # TDD create work experiences
  # Description: create work experiences with end year is not number
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'create work experiences with end year is not number' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2000
    end_year = 'abc'
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:end_year]
    puts (assigns(:work_experience).errors[:end_year])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience
  end

  # Description: create work experiences with end year is less than 1905
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'create work experiences with end year is less than 1905' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2000
    end_year = 1900
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:end_year]
    puts (assigns(:work_experience).errors[:end_year])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience

  end

  # TDD create work experiences
  # Description: create work experiences with end year is greater than now
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'create work experiences with end year is greater than now' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2000
    end_year = Time.now.year + 1
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:end_year]
    puts (assigns(:work_experience).errors[:end_year])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience
  end

  # TDD create work experiences
  # Description: create work experiences with end year is less than start year
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'create work experiences with end year is less than start year' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2000
    end_year = 1995
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:end_year]
    puts (assigns(:work_experience).errors[:end_year])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience
  end

  # TDD create work experiences
  # Description: create work experiences with work place length is greater than 200
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'create work experiences with work place length is greater than 200' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2000
    end_year = 2001
    work_place = ''
    for i in 1..201
      work_place = work_place + 'a'
    end
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:work_place]
    puts (assigns(:work_experience).errors[:work_place])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience
  end

  # TDD create work experiences
  # Description: create work experiences with work place with white space first and end
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'create work experiences with work place with white space first and end' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2000
    end_year = 2001
    work_place = '       work place       '
    description = 'description'

    #delete data
    assert WorkExperience.delete_all(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place.strip, description: description)

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    work_experience = assigns(:work_experience)

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place.strip, description: description)
    assert_equal expected_work_experience, work_experience
  end

  # TDD create work experiences
  # Description: create work experiences with description length is greater than 200
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'create work experiences with description length is greater than 200' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2000
    end_year = 2001
    work_place = 'work place'

    description = ''
    for i in 1..201
      description = description + 'a'
    end

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:description]
    puts (assigns(:work_experience).errors[:description])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description.strip)
    assert_nil expected_work_experience
  end

  # TDD create work experiences
  # Description: create work experiences with description with white space first and end
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'create work experiences with description with white space first and end' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2000
    end_year = 2001
    work_place = 'work place'
    description = '        description    '

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    work_experience = assigns(:work_experience)

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description.strip)
    assert_equal expected_work_experience, work_experience
  end


  # Description: edit work experience successful
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'edit work experience successful' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description edit test'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    edit_category_id = Category.find_by(category_name: 'Fashion/Lifestyle').id.to_s
    edit_level_id = Level.find_by(category_id: edit_category_id, level_order: 1).id.to_s

    # edit_category_id = '5466bc0f4875791039ab0000'
    # edit_level_id = '5466bc0f4875791039ac0000'

    edit_current = true
    edit_start_year = 2012
    edit_end_year = ''
    edit_work_place = 'updated work place '
    edit_description = 'updated description edit test'

    post :update, :id => work_experience.id.to_s, :work_experience => { :category_id => edit_category_id, :level_id => edit_level_id, :current => edit_current, :start_year => edit_start_year, :end_year => edit_end_year, :work_place => edit_work_place, :description => edit_description}, :format => 'js'

    work_experience = assigns(:work_experience)

    expected_work_experience = WorkExperience.find_by(id: work_experience.id)
    assert_equal expected_work_experience, work_experience
  end


  #edit not existed
  # Description: edit work experience not existed
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'edit work experience not existed' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description edit test'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    edit_category_id = Category.find_by(category_name: 'Fashion/Lifestyle').id.to_s
    edit_level_id = Level.find_by(category_id: edit_category_id, level_order: 1).id.to_s

    edit_current = true
    edit_start_year = 2012
    edit_end_year = ''
    edit_work_place = 'updated work place '
    edit_description = 'updated description edit test'

    assert WorkExperience.delete_all(_id: work_experience.id)

    post :update, :id => work_experience.id.to_s, :work_experience => { :category_id => edit_category_id, :level_id => edit_level_id, :current => edit_current, :start_year => edit_start_year, :end_year => edit_end_year, :work_place => edit_work_place, :description => edit_description}, :format => 'js'

    assert_equal flash.now[:error], I18n.t('work_experiences.msg_work_experience_not_found')
  end

  # Description: edit work experiences with category is nil
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'edit work experience with category is nil' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description edit test'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    edit_category_id = nil
    edit_level_id = nil

    edit_current = true
    edit_start_year = 2012
    edit_end_year = ''
    edit_work_place = 'updated work place '
    edit_description = 'updated description edit test'

    post :update, :id => work_experience.id.to_s, :work_experience => { :category_id => edit_category_id}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:category]

    expected_work_experience = WorkExperience.find_by(id: work_experience.id)
    assert expected_work_experience.category_id, work_experience.category_id
    assert expected_work_experience.level_id, work_experience.level_id
  end

  # Description: edit work experiences with level is nil
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'edit work experience with level is nil' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description edit test'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    edit_category_id = Category.find_by(category_name: 'IT').id.to_s
    edit_level_id = nil

    edit_current = true
    edit_start_year = 2012
    edit_end_year = ''
    edit_work_place = 'updated work place '
    edit_description = 'updated description edit test'

    post :update, :id => work_experience.id.to_s, :work_experience => { :level_id => edit_level_id}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:level]

    expected_work_experience = WorkExperience.find_by(id: work_experience.id)
    assert_not_equal expected_work_experience.level_id, edit_category_id
  end

  # Description: edit work experience with start year is nil
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'edit work experience with start year is nil' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description edit test'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    edit_category_id = Category.find_by(category_name: 'IT').id.to_s
    edit_level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    edit_current = true
    edit_start_year = ''
    edit_end_year = ''
    edit_work_place = 'updated work place '
    edit_description = 'updated description edit test'

    post :update, :id => work_experience.id.to_s, :work_experience => {:start_year => edit_start_year}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:start_year]

    expected_work_experience = WorkExperience.find_by(id: work_experience.id)
    assert expected_work_experience.start_year, edit_start_year

  end

  # Description: edit work experience with start year is not number
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'edit work experience with start year is not number' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description edit test'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    edit_category_id = Category.find_by(category_name: 'IT').id.to_s
    edit_level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    edit_current = true
    edit_start_year = 'abc'
    edit_end_year = ''
    edit_work_place = 'updated work place '
    edit_description = 'updated description edit test'

    post :update, :id => work_experience.id.to_s, :work_experience => {:start_year => edit_start_year}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:start_year]

    expected_work_experience = WorkExperience.find_by(id: work_experience.id)
    assert expected_work_experience.start_year, edit_start_year

  end

  # Description: edit work experience with start year is less than 1905
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'edit work experience with start year is less than 1905' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description edit test'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    edit_category_id = Category.find_by(category_name: 'IT').id.to_s
    edit_level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    edit_current = true
    edit_start_year = '1900'
    edit_end_year = ''
    edit_work_place = 'updated work place '
    edit_description = 'updated description edit test'

    post :update, :id => work_experience.id.to_s, :work_experience => {:start_year => edit_start_year}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:start_year]

    expected_work_experience = WorkExperience.find_by(id: work_experience.id)
    assert expected_work_experience.start_year, edit_start_year

  end

  # Description: edit work experience with start year is greater than now
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'edit work experience with start year is greater than now' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description edit test'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    edit_category_id = Category.find_by(category_name: 'IT').id.to_s
    edit_level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    edit_current = true
    edit_start_year = '2016'
    edit_end_year = ''
    edit_work_place = 'updated work place '
    edit_description = 'updated description edit test'

    post :update, :id => work_experience.id.to_s, :work_experience => {:start_year => edit_start_year}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:start_year]

    expected_work_experience = WorkExperience.find_by(id: work_experience.id)
    assert expected_work_experience.start_year, edit_start_year

  end

  # Description: edit work experience with end year is not number
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'edit work experience with end year is not number' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description edit test'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    edit_category_id = Category.find_by(category_name: 'IT').id.to_s
    edit_level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    edit_current = true
    edit_start_year = '2000'
    edit_end_year = 'abc'
    edit_work_place = 'updated work place '
    edit_description = 'updated description edit test'

    post :update, :id => work_experience.id.to_s, :work_experience => {:end_year => edit_end_year}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:end_year]

    expected_work_experience = WorkExperience.find_by(id: work_experience.id)
    assert expected_work_experience.end_year, edit_end_year

  end

  # Description: edit work experience with end year is less than 1905
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'edit work experience with end year is less than 1905' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description edit test'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    edit_category_id = Category.find_by(category_name: 'IT').id.to_s
    edit_level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    edit_current = true
    edit_start_year = '2000'
    edit_end_year = '1900'
    edit_work_place = 'updated work place '
    edit_description = 'updated description edit test'

    post :update, :id => work_experience.id.to_s, :work_experience => {:end_year => edit_end_year}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:end_year]

    expected_work_experience = WorkExperience.find_by(id: work_experience.id)
    assert expected_work_experience.end_year, edit_end_year

  end

  # Description: edit work experience with end year is greater than now
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'edit work experience with end year is greater than now' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description edit test'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    edit_category_id = Category.find_by(category_name: 'IT').id.to_s
    edit_level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    edit_current = true
    edit_start_year = '2000'
    edit_end_year = '2017'
    edit_work_place = 'updated work place '
    edit_description = 'updated description edit test'

    post :update, :id => work_experience.id.to_s, :work_experience => {:end_year => edit_end_year}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:end_year]

    expected_work_experience = WorkExperience.find_by(id: work_experience.id)
    assert expected_work_experience.end_year, edit_end_year

  end


  # Description: edit work experience with end year is less than start year
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'edit work experience with end year is less than start year' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description edit test'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    edit_category_id = Category.find_by(category_name: 'IT').id.to_s
    edit_level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    edit_current = true
    edit_start_year = '2000'
    edit_end_year = '1990'
    edit_work_place = 'updated work place '
    edit_description = 'updated description edit test'

    post :update, :id => work_experience.id.to_s, :work_experience => {:end_year => edit_end_year}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:end_year]
    puts (assigns(:work_experience).errors.full_messages.to_sentence)

    expected_work_experience = WorkExperience.find_by(id: work_experience.id)
    assert_not_equal expected_work_experience.end_year, edit_end_year
  end


  # Description: edit work experience with work place length is greater than 200
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'edit work experience  with work place length is greater than 200' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description edit test'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    edit_category_id = Category.find_by(category_name: 'IT').id.to_s
    edit_level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    edit_current = true
    edit_start_year = '2000'
    edit_end_year = '1990'
    edit_work_place = ''
    for i in 1..201
      edit_work_place = edit_work_place + 'a'
    end
    edit_description = 'updated description edit test'

    post :update, :id => work_experience.id.to_s, :work_experience => {:work_place => edit_work_place}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:work_place]
    puts (assigns(:work_experience).errors.full_messages.to_sentence)

    expected_work_experience = WorkExperience.find_by(id: work_experience.id)
    assert_not_equal expected_work_experience.work_place, edit_work_place
  end


  # Description: edit work experience with work place with white space first and end
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'edit work experience  with work place with white space first and end' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description edit test'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    edit_category_id = Category.find_by(category_name: 'IT').id.to_s
    edit_level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    edit_current = true
    edit_start_year = '2000'
    edit_end_year = '1990'
    edit_work_place = '   updated edit work place whit white space     '

    edit_description = 'updated description edit test'

    post :update, :id => work_experience.id.to_s, :work_experience => {:work_place => edit_work_place}, :format => 'js'

    assert_empty assigns(:work_experience).errors[:work_place]
    # puts (assigns(:work_experience).errors.full_messages.to_sentence)

    expected_work_experience = WorkExperience.find_by(id: work_experience.id)
    assert_equal expected_work_experience.work_place, edit_work_place.strip
  end

  # Description: edit work experience with work place length is greater than 200
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'edit work experience  with description length is greater than 200' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description edit test'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    edit_category_id = Category.find_by(category_name: 'IT').id.to_s
    edit_level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    edit_current = true
    edit_start_year = '2000'
    edit_end_year = '1990'
    edit_work_place = 'abc'

    edit_description = ''
    for i in 1..201
      edit_description = edit_description + 'a'
    end

    post :update, :id => work_experience.id.to_s, :work_experience => {:description => edit_description}, :format => 'js'

    assert_not_empty assigns(:work_experience).errors[:description]
    puts (assigns(:work_experience).errors.full_messages.to_sentence)

    expected_work_experience = WorkExperience.find_by(id: work_experience.id)
    assert_not_equal expected_work_experience.description, edit_description
  end


  # Description: edit work experience with work place with white space first and end
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'edit work experience with description with white space first and end' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description edit test'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    edit_category_id = Category.find_by(category_name: 'IT').id.to_s
    edit_level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    edit_current = true
    edit_start_year = '2000'
    edit_end_year = '1990'
    edit_work_place = 'updated edit work place whit white space'

    edit_description = '   updated description edit test    '

    post :update, :id => work_experience.id.to_s, :work_experience => {:description => edit_description}, :format => 'js'

    assert_empty assigns(:work_experience).errors[:work_place]
    # puts (assigns(:work_experience).errors.full_messages.to_sentence)

    expected_work_experience = WorkExperience.find_by(id: work_experience.id)
    assert_equal expected_work_experience.description, edit_description.strip
  end

  #delete successful
  # Description: delete work experience successful
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'delete successful' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description test delete'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    # delete :destroy, :id => work_experience.id, :format => 'js'

    # assert_nil WorkExperience.find_by(id: work_experience.id)
  end

  #delete not existed
  # Description: delete work experience not existed'
  # @author: HuyenDT
  # Create Date: 22/12/2014
  # Modify Date:
  test 'delete work experience not existed' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description test delete'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    assert WorkExperience.delete_all(_id: work_experience.id)

    delete :destroy, :id => work_experience.id, :format => 'js'

    assert_equal flash.now[:error], I18n.t('work_experiences.msg_work_experience_not_found')
  end


end