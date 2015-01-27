require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get search_curriculum" do
    get :search_curriculum
    assert_response :success
  end

  # @author: HUyenDT
  test "search by category is empty" do
    #input params
    user = User.find_by(user_name: 'huyendt')
    category_id = ''
    level_id = ''
    keyword = ''
    page = 1


    # send request get to search curriculum
    get :search_curriculum, {:category_id => category_id, :level_id => level_id, :keyword => keyword, :page => page}, {:user_id => user.id}
    results = assigns(:curriculums)

    assert results.nil?
    #assert_equal flash.now[:error], I18n.t('search_curriculum.msg_category_required')
  end

  # @author: HuyenDT
  test "search by a category" do
    #input params
    user = User.find_by(user_name: 'huyendt')
    category_id = Category.find_by(category_name: 'IT').id
    level_id = ''
    keyword = ''
    page = 1


    # send request get to search curriculum
    get :search_curriculum, {:category_id => category_id, :level_id => level_id, :keyword => keyword, :page => page}, {:user_id => user.id}
    results = assigns(:curriculums)
    total_entries = results.total_entries

    #expected total entries
    expected_total_entries = Curriculum.where(category_id: category_id, status: 1).count()

    #search data in database
    expected_results = Curriculum.where('curriculum_categories.category_id' => category_id, status: 1).order_by(created_at: -1, curriculum_name: 1).limit(SearchController::ITEM_PER_PAGE)

    assert_equal total_entries, expected_total_entries, 'Total entries are not equal'

    assert (expected_results == results)

    results.each do |curr|
      puts curr.curriculum_name
    end
  end

  # @author: HuyenDT
  # test "search by a category have childs" do
  #   #input params
  #   user = User.find_by(user_name: 'huyendt')
  #   category_id = Category.find_by(category_name: 'IT').id
  #   keyword = ''
  #   page = 1
  #
  #
  #   # send request get to search curriculum
  #   get :search_curriculum, {:category_id => category_id, :keyword => keyword, :page => page}, {:user_id => user.id}
  #   results = assigns(:curriculums)
  #
  #
  #   #search child of category
  #   category_ids = [category_id]
  #   category_childs = Category.any_in(ancestors: category_id)
  #   category_childs.each do |child|
  #     category_ids << child.id
  #   end
  #
  #   #search data in database
  #   expected_results = Curriculum.any_in(category_id: category_ids).and(status: 1).order_by(created_at: -1, curriculum_name: 1).limit(SearchController::ITEM_PER_PAGE)
  #
  #   assert (expected_results == results)
  #
  #   results.each do |curr|
  #     puts curr.curriculum_name
  #   end
  # end

  # @author: HuyenDT
  test "search by a category and keyword with special characters" do
    user = User.find_by(user_name: 'huyendt')
    category_id = Category.find_by(category_name: 'IT').id
    level_id = ''
    keyword = '>'
    #keyword = 'curriculum'
    page = 1



    # send request get to search curriculum
    # get :search_curriculum, {:category_id => category_id, :level_id => level_id,  :keyword => keyword, :page => page}, {:user_id => user.id}
    # results = assigns(:curriculums)
    # total_entries = results.total_entries

    #pattern = /(\'|\"|\.|\*|\/|\-|\\|\)|\$|\+|\(|\^|\?|\!|\~|\`)/
    #pattern = /(\'|\"|\.|\*|\/|\-|\\|\&|\(|\)|\^|\%|\$|\#\>\<\?\{\}\[\])/
    pattern = /(\'|\"|\.|\*|\/|\-|\\|\&|\(|\)|\^|\%|\$|\#|\>|\<|\?|\{|\}|\[|\]|\~|\+)/
    keyword = keyword.gsub(pattern){|match|"\\"  + match} # <-- Trying to take the currently found match and add a \ before it I have no idea how to do that).
    puts(keyword)

    #expected total entries
    expected_total_entries = Curriculum.where('curriculum_categories.category_id' => category_id, curriculum_name: /#{keyword}/i, status: 1).count()

    #search data in database
    expected_results = Curriculum.where('curriculum_categories.category_id' => category_id, curriculum_name: /#{keyword}/i, status: 1).order_by(created_at: -1, curriculum_name: 1).limit(SearchController::ITEM_PER_PAGE)

    # assert_equal total_entries, expected_total_entries, 'Total entries are not equal'
    # assert (expected_results == results)
    #
    # puts(total_entries)
    expected_results.each do |curr|
      puts curr.curriculum_name
    end
  end

  # @author: HuyenDT
  test "search by a category and keyword is same curriculum name" do
    #input params
    user = User.find_by(user_name: 'huyendt')
    category_id = Category.find_by(category_name: 'IT').id
    level_id = ''
    keyword = 'curriculum 2 IT'
    page = 1


    # send request get to search curriculum
    get :search_curriculum, {:category_id => category_id, :level_id  => level_id, :keyword => keyword, :page => page}, {:user_id => user.id}
    results = assigns(:curriculums)
    total_entries = results.total_entries

    expected_total_entries = expected_results = Curriculum.where('curriculum_categories.category_id' => category_id, curriculum_name: keyword, status: 1).count()

    #search data in database
    expected_results = Curriculum.where('curriculum_categories.category_id' => category_id, curriculum_name: keyword, status: 1).order_by(created_at: -1, curriculum_name: 1).limit(SearchController::ITEM_PER_PAGE)

    assert_equal expected_total_entries, total_entries, 'total entries are equals'

    assert (expected_results == results)

    results.each do |curr|
      puts curr.curriculum_name
    end
  end

  test "search by a category and keyword is upper of same curriculum name" do
    #input params
    user = User.find_by(user_name: 'huyendt')
    category_id = Category.find_by(category_name: 'IT').id
    keyword = 'CURRICULUM 2 IT'
    page = 1


    # send request get to search curriculum
    get :search_curriculum, {:category_id => category_id, :keyword => keyword, :page => page}, {:user_id => user.id}
    results = assigns(:curriculums)
    total_entries = results.total_entries

    #search data in database
    expected_total_entries = Curriculum.where('curriculum_categories.category_id' => category_id, curriculum_name: /#{keyword}/i, status: 1).count()

    #search data in database
    expected_results = Curriculum.where('curriculum_categories.category_id' => category_id, curriculum_name: /#{keyword}/i, status: 1).order_by(created_at: -1, curriculum_name: 1).limit(SearchController::ITEM_PER_PAGE)

    assert_equal expected_total_entries, total_entries
    assert (expected_results == results)

    results.each do |curr|
      puts curr.curriculum_name
    end
  end

  test "search by a category and keyword like curriculum name" do
    #input params
    user = User.find_by(user_name: 'huyendt')
    category_id = Category.find_by(category_name: 'IT').id
    #keyword = 'CURRICULUM 10 IT'
    keyword = 'CURRICULUM 2'
    page = 1



    # send request get to search curriculum
    get :search_curriculum, {:category_id => category_id, :keyword => keyword, :page => page}, {:user_id => user.id}
    results = assigns(:curriculums)
    total_entries = results.total_entries

    expected_total_entries = Curriculum.where('curriculum_categories.category_id' => category_id, curriculum_name: /#{keyword}/i, status: 1).order_by(created_at: -1, curriculum_name: 1).count()

    #search data in database
    expected_results = Curriculum.where('curriculum_categories.category_id' => category_id, curriculum_name: /#{keyword}/i, status: 1).order_by(created_at: -1, curriculum_name: 1).limit(SearchController::ITEM_PER_PAGE)

    assert_equal expected_total_entries, total_entries
    assert (expected_results == results)

    results.each do |curr|
      puts curr.curriculum_name
    end
  end

  # @author: HuyenDT
  test "search by a category and keyword with white space at the beginning and end" do
    #input params
    user = User.find_by(user_name: 'huyendt')
    category_id = Category.find_by(category_name: 'IT').id
    level_id = ''
    #keyword = 'CURRICULUM 10 IT'
    keyword = '                CURRICULUM 1            '
    page = 1


    # send request get to search curriculum
    get :search_curriculum, {:category_id => category_id, :level_id => level_id,  :keyword => keyword, :page => page}, {:user_id => user.id}
    results = assigns(:curriculums)
    total_entries = results.total_entries

    expected_total_entries = Curriculum.where('curriculum_categories.category_id'=> category_id, curriculum_name: /#{keyword.strip}/i, status: 1).count()

    #search data in database
    expected_results = Curriculum.where('curriculum_categories.category_id'=> category_id, curriculum_name: /#{keyword.strip}/i, status: 1).order_by(created_at: -1, curriculum_name: 1).limit(SearchController::ITEM_PER_PAGE)

    assert_equal total_entries, expected_total_entries, 'Total entries are equals'

    assert (expected_results == results)

    results.each do |curr|
      puts curr.curriculum_name
    end
  end

  test "search with paginate" do
    #input params
    user = User.find_by(user_name: 'huyendt')
    category_id = Category.find_by(category_name: 'IT').id
    keyword = ''
    page = 2

    # send request get to search curriculum
    get :search_curriculum, {:category_id => category_id, :keyword => keyword, :page => page}, {:user_id => user.id}
    results = assigns(:curriculums)

    #search data in database
    expected_results = Curriculum.where('curriculum_categories.category_id'=> category_id, curriculum_name: /#{keyword.strip}/i, status: 1).order_by(created_at: -1, curriculum_name: 1).skip(SearchController::ITEM_PER_PAGE).limit(SearchController::ITEM_PER_PAGE)

    assert (expected_results == results)

    results.each do |curr|
      puts curr.curriculum_name
    end
  end

  # @author: HuyenDT
  test "search by a category, level and keyword" do
    #input params
    user = User.find_by(user_name: 'huyendt')
    category_id = Category.find_by(category_name: 'IT').id
    level_id = Level.find_by(category_id: category_id, level_order: 1).id
    #keyword = 'CURRICULUM 10 IT'
    keyword = 'curriculum'
    page = 1


    # send request get to search curriculum
    get :search_curriculum, {:category_id => category_id, :level_id => level_id,  :keyword => keyword, :page => page}, {:user_id => user.id}
    results = assigns(:curriculums)
    total_entries = results.total_entries

    expected_total_entries = Curriculum.where('curriculum_categories.category_id'=> category_id,'curriculum_categories.level_ids'=> level_id, curriculum_name: /#{keyword.strip}/i, status: 1).count()

    #search data in database
    expected_results = Curriculum.where('curriculum_categories.category_id'=> category_id, 'curriculum_categories.level_ids'=> level_id,  curriculum_name: /#{keyword.strip}/i, status: 1).order_by(created_at: -1, curriculum_name: 1).limit(SearchController::ITEM_PER_PAGE)

    assert_equal total_entries, expected_total_entries, 'Total entries are equals'

    assert (expected_results == results)

    results.each do |curr|
      puts curr.curriculum_name
    end
  end

end
