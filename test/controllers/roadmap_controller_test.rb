require 'test_helper'

class RoadmapControllerTest < ActionController::TestCase

  # Description: view list roadmap: check authorixation
  # @author: HaPT
  # Create Date: 5/12/2014
  # Modify Date:
  test "check authorization" do
    get :index
    assert_redirected_to signin_path
  end

  # Description: view list roadmap: view default roadmap
  # @author: HaPT
  # Create Date: 5/12/2014
  # Modify Date:
  test "view default roadmap" do
    user = User.find_by(user_name: 'phanha89')
    UserCategory.delete_all(user_id: user.id)
    session[:user_id] = user.id
    get :index
    assert_response :success
    assert_not_nil assigns(:user_categories)
    user_category = UserCategory.where(user_id: nil)
    # assert_select 'div#roadmap-chart' + user_category[0].id
    user_categories = assigns(:user_categories)
    assert_not_nil user_categories
    # assert user_category.eql?(user_categories)
    #   puts user_category.category.category_name
    #   puts user_category.level.level_name
  end

  # Description: view list roadmap: view my roadmap
  # @author: HaPT
  # Create Date: 5/12/2014
  # Modify Date:
  test "view my roadmap" do
    user = User.find_by(user_name: 'phanha89')
    session[:user_id] = user.id
    category = Category.find_by(category_name: 'IT')
    level = Level.find_by(level_name: 'Manager')
    assert UserCategory.create(user_id: user.id, category_id: category.id, level_id: level.id)
    category = Category.find_by(category_name: 'Banking')
    level = Level.find_by(level_name: 'Manager')
    assert UserCategory.create(user_id: user.id, category_id: category.id, level_id: level.id)
    get :index
    assert_response :success
    assert_not_nil assigns(:user_categories)
    user_categories = assigns(:user_categories)
    puts '-----------Output on form:-----------------'
    user_categories.each do |category_user|
      puts category_user.category.category_name
      puts category_user.level.level_name
      # assert_select 'div#roadmap-chart' + category_user.category.id
    end
    puts '-----------Output on database:------------'
    user_categoriesDB = user_categories = UserCategory.where(user_id: user.id).order_by(created_at: -1).limit(5)
    user_categoriesDB.each do |category_user|
      puts category_user.category.category_name
      puts category_user.level.level_name
    end
    assert_equal(user_categories,user_categoriesDB)
  end

  # Description: view list roadmap: view 5 roadmaps with user have more 5 roadmaps
  # @author: HaPT
  # Create Date: 5/12/2014
  # Modify Date:
  test "view my roadmap with more 5 roadmaps" do
    user = User.find_by(user_name: 'phanha89')
    session[:user_id] = user.id

    category = Category.find_by(category_name: 'Administrative/Clerical')
    level = Level.find_by(level_name: 'Manager')
    assert UserCategory.create(user_id: user.id, category_id: category.id, level_id: level.id)

    category = Category.find_by(category_name: 'Advertising/Promotion/PR')
    level = Level.find_by(level_name: 'New Grad/Entry Level/Internship')
    assert UserCategory.create(user_id: user.id, category_id: category.id, level_id: level.id)

    category = Category.find_by(category_name: 'Warehouse')
    level = Level.find_by(level_name: 'New Grad/Entry Level/Internship')
    assert UserCategory.create(user_id: user.id, category_id: category.id, level_id: level.id)

    category = Category.find_by(category_name: 'Airlines/Tourism/Hotel')
    level = Level.find_by(level_name: 'Manager')
    assert UserCategory.create(user_id: user.id, category_id: category.id, level_id: level.id)

    category = Category.find_by(category_name: 'Architecture/Interior Design')
    level = Level.find_by(level_name: 'Manager')
    assert UserCategory.create(user_id: user.id, category_id: category.id, level_id: level.id)

    category = Category.find_by(category_name: 'Arts/Design')
    level = Level.find_by(level_name: 'Manager')
    assert UserCategory.create(user_id: user.id, category_id: category.id, level_id: level.id)

    get :index
    assert_response :success
    assert_not_nil assigns(:user_categories)
    user_categories = assigns(:user_categories)
    puts '-----------Output on form:-----------------'
    user_categories.each do |category_user|
      puts category_user.category.category_name
      puts category_user.level.level_name
      # assert_select 'div#roadmap-chart' + category_user.category.id
    end
    puts '-----------Output on database:------------'
    user_categoriesDB = user_categories = UserCategory.where(user_id: user.id).order_by(created_at: -1).limit(5)
    user_categoriesDB.each do |category_user|
      puts category_user.category.category_name
      puts category_user.level.level_name
    end
    assert_equal(user_categories,user_categoriesDB)
    # assert_select 'button#load-more'
  end

  # Description: view list roadmap: click load more roadmap
  # @author: HaPT
  # Create Date: 5/12/2014
  # Modify Date:
  test "view more roadmap" do
    user = User.find_by(user_name: 'phanha89')
    session[:user_id] = user.id
    get :index
    assert_response :success
    assert_not_nil assigns(:user_categories)
    user_categories = assigns(:user_categories)
    last_roadmap_id = ''
    user_categories.each do |category_user|
      puts category_user.category.category_name
      puts category_user.level.level_name
      last_roadmap_id = category_user.id
    end
    get :get_more_roadmap, :last_roadmap_id => last_roadmap_id
    user_categories = assigns(:user_categories)
    puts '-----------Output on form:-----------------'
    user_categories.each do |category_user|
      puts category_user.category.category_name
      puts category_user.level.level_name
    end
    puts '-----------Output on database:------------'
    user_categoriesDB = user_categories = UserCategory.where(user_id: user.id).lt(_id: last_roadmap_id).order_by(created_at: -1).limit(5)
    user_categoriesDB.each do |category_user|
      puts category_user.category.category_name
      puts category_user.level.level_name
    end
    assert_equal(user_categories,user_categoriesDB)
  end

  # Description: Create roadmap: create successful
  # @author: HaPT
  # Create Date: 5/12/2014
  # Modify Date:
  test "create successful roadmap" do
    user = User.find_by(user_name: 'phanha89')
    session[:user_id] = user.id
    category = Category.find_by(category_name: 'Executive management')
    level = Level.find_by(level_name: 'New Grad/Entry Level/Internship')
    UserCategory.delete_all(user_id: user.id, category_id: category.id)
    get :create, {:category_id =>category.id, :level_id => level.id}
    assert user_category = UserCategory.find_by(user_id: user.id, category_id: category.id, level_id: level.id)
  end

  # Description: Create roadmap: create a roadmap that is exist for user
  # @author: HaPT
  # Create Date: 5/12/2014
  # Modify Date:
  test "create roadmap exist" do
    user = User.find_by(user_name: 'phanha89')
    session[:user_id] = user.id
    category = Category.find_by(category_name: 'Executive management')
    level = Level.find_by(level_name: 'Manager')
    UserCategory.delete_all(user_id: user.id, category_id: category.id)
    UserCategory.create(user_id: user.id, category_id: category.id, level_id: level.id)
    get :create, {:category_id =>category.id, :level_id => level.id}
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end
  end

  # Description: Create roadmap: create roadmap with category is null
  # @author: HaPT
  # Create Date: 5/12/2014
  # Modify Date:
  test "create roadmap with category is null" do
    user = User.find_by(user_name: 'phanha89')
    session[:user_id] = user.id
    category = Category.find_by(category_name: 'Executive management')
    UserCategory.delete_all(user_id: user.id, category_id: category.id)
    level = Level.find_by(level_name: 'Manager')
    get :create, { :level_id => level.id}
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end
  end

  # Description: Create roadmap: create roadmap with level is null
  # @author: HaPT
  # Create Date: 5/12/2014
  # Modify Date:
  test "create roadmap with level is null" do
    user = User.find_by(user_name: 'phanha89')
    session[:user_id] = user.id
    category = Category.find_by(category_name: 'Executive management')
    UserCategory.delete_all(user_id: user.id, category_id: category.id)
    level = Level.find_by(level_name: 'Manager')
    get :create, { :category_id =>category.id}
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end
  end

  # Description: Create roadmap: create roadmap with category and level are null
  # @author: HaPT
  # Create Date: 5/12/2014
  # Modify Date:
  test "create roadmap with category and level is null" do
    user = User.find_by(user_name: 'phanha89')
    session[:user_id] = user.id
    category = Category.find_by(category_name: 'Executive management')
    UserCategory.delete_all(user_id: user.id, category_id: category.id)
    level = Level.find_by(level_name: 'Manager')
    get :create
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end
  end

  # Description: Update roadmap: Update roadmap with higher level
  # @author: HaPT
  # Create Date: 22/12/2014
  # Modify Date:
  test "update roadmap with higher level" do
    user = User.find_by(user_name: 'phanha89')
    session[:user_id] = user.id

    # initialization data
    category = Category.find_by(category_name: 'IT')
    level_current = Level.find_by(level_name: 'Experienced (Non-Manager)',category_id: category.id)
    assert UserCategory.delete_all(user_id: user.id, category_id: category.id)
    assert user_category = UserCategory.create(user_id: user.id, category_id: category.id, level_id: level_current.id)
    level = Level.find_by(level_name: 'Manager',category_id: category.id)

    # call method from controller
    post :update, {:roadmap_id =>user_category.id, :level_id => level.id}

    # check result
    user_category_updated = UserCategory.find_by(id: user_category.id)
    assert_not_equal(user_category.level.id,user_category_updated.level.id)
  end

  # Description: Update roadmap: Update roadmap with smaller level
  # @author: HaPT
  # Create Date: 22/12/2014
  # Modify Date:
  test "update roadmap with smaller level" do
    user = User.find_by(user_name: 'phanha89')
    session[:user_id] = user.id

    # initialization data
    category = Category.find_by(category_name: 'IT')
    level_current = Level.find_by(level_name: 'Manager',category_id: category.id)
    assert UserCategory.delete_all(user_id: user.id, category_id: category.id)
    assert user_category = UserCategory.create(user_id: user.id, category_id: category.id, level_id: level_current.id)
    level = Level.find_by(level_name: 'Experienced (Non-Manager)',category_id: category.id)

    # call method from controller
    post :update, {:roadmap_id =>user_category.id, :level_id => level.id}

    # check result
    user_category_updated = UserCategory.find_by(id: user_category.id)
    assert_not_equal(user_category.level.id,user_category_updated.level.id)
  end


  # Description: Update roadmap: Update roadmap with equal level
  # @author: HaPT
  # Create Date: 22/12/2014
  # Modify Date:
  test "update roadmap with equal level" do
    user = User.find_by(user_name: 'phanha89')
    session[:user_id] = user.id

    # initialization data
    category = Category.find_by(category_name: 'IT')
    level_current = Level.find_by(level_name: 'Manager',category_id: category.id)
    assert UserCategory.delete_all(user_id: user.id, category_id: category.id)
    assert user_category = UserCategory.create(user_id: user.id, category_id: category.id, level_id: level_current.id)
    level = Level.find_by(level_name: 'Manager',category_id: category.id)

    # call method from controller
    post :update, {:roadmap_id =>user_category.id, :level_id => level.id}

    # check result
    user_category_updated = UserCategory.find_by(id: user_category.id)
    assert_equal(user_category.level.id,user_category_updated.level.id)
  end

  # Description: Update roadmap: Update roadmap with level is null
  # @author: HaPT
  # Create Date: 22/12/2014
  # Modify Date:
  test "update roadmap with level is null" do
    user = User.find_by(user_name: 'phanha89')
    session[:user_id] = user.id

    # initialization data
    category = Category.find_by(category_name: 'IT')
    level_current = Level.find_by(level_name: 'Manager',category_id: category.id)
    assert UserCategory.delete_all(user_id: user.id, category_id: category.id)
    assert user_category = UserCategory.create(user_id: user.id, category_id: category.id, level_id: level_current.id)

    # call method from controller
    post :update, {:roadmap_id => user_category.id}

    # check result
    assert flash[:error]
    if flash[:error].instance_of?Array
      flash[:error].each do |message|
        puts message
      end
    else
      puts flash[:error]
    end
  end


  # Description: Delete roadmap: Delete roadmap successful
  # @author: HaPT
  # Create Date: 22/12/2014
  # Modify Date:
  test "delete roadmap" do
    user = User.find_by(user_name: 'phanha89')
    session[:user_id] = user.id

    # initialization data
    category = Category.find_by(category_name: 'IT')
    level = Level.find_by(level_name: 'Manager',category_id: category.id)
    assert UserCategory.delete_all(user_id: user.id, category_id: category.id)
    assert user_category = UserCategory.create(user_id: user.id, category_id: category.id, level_id: level.id)

    # call method from controller
    post :delete, {:roadmap_id => user_category.id}

    # check result
    assert_nil UserCategory.find_by(id: user_category.id)
  end

  # Description: Delete roadmap: Delete roadmap successful
  # @author: HaPT
  # Create Date: 22/12/2014
  # Modify Date:
  test "delete roadmap with user has only one roadmap" do
    user = User.find_by(user_name: 'phanha89')
    session[:user_id] = user.id
    # initialization data
    category = Category.find_by(category_name: 'IT')
    level = Level.find_by(level_name: 'Manager',category_id: category.id)
    assert UserCategory.delete_all(user_id: user.id)
    assert user_category = UserCategory.create(user_id: user.id, category_id: category.id, level_id: level.id)

    # call method from controller
    get :index
    assert_response :success
    assert_select 'div#roadmap-chart' + user_category.id
    post :delete, {:roadmap_id => user_category.id}
    assert_nil UserCategory.find_by(id: user_category.id)
    get :index

    # check result
    assert_select 'div#roadmap-chart-default'
  end

end
