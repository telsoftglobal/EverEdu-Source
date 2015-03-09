require 'test_helper'

class CurriculumControllerTest < ActionController::TestCase
  # Description: view list curriculum: when mentor log in to system
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view all curriculums of mentor" do
    @current_user = User.find_by(_id:BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    # assert :index
    get :index, {:category_id => '', :keyword => '', :page => 1}
    # assert_response :success

    assert_not_nil curriculums
    # assert_nil @curriculums.nil?
  end

  # Description: view list curriculum: mentor click button search, no option category and input curriculum name
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view all curriculums when click search button " do
    @current_user = User.find_by(_id:BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    post :index
    assert_not_nil @curriculums
    # assert_nil @curriculums.nil?
  end

  # Description: view list curriculum: mentor seach with only category
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum when only option category" do
    @current_user = User.find_by(_id:BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    post :index, :category_id => '546484ed4875793289200100', :keyword => 'curriculum 2'
    assert_not_nil @curriculums
    # assert_nil @curriculums.nil?
  end

  # Description: view list curriculum: mentor seach with only curriculum_name
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum when only enter curriculum_name" do
    @current_user = User.find_by(_id:BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    post :index, :keyword => 'curriculum 2'
    assert_not_nil @curriculums
    # assert_nil @curriculums.nil?
  end

  # Description: view list curriculum: mentor seach with curriculum_name only input special characters
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum when only enter curriculum_name with special characters" do
    @current_user = User.find_by(_id:BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    post :index, :keyword => '&*()&^%$#'
    # assert_not_nil !@curriculums.nil?
    assert_nil @curriculums
  end

  # Description: view list curriculum: mentor seach with curriculum_name only input number
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum when only enter curriculum_name with number only" do
    @current_user = User.find_by(_id:BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    post :index, :keyword => '12345'
    # assert_not_nil !@curriculums.nil?
    assert_nil @curriculums
  end

  # Description: view list curriculum: mentor seach with curriculum_name input alphanumeric characters and special characters
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum when only enter curriculum_name with alphanumeric characters and special characters" do
    @current_user = User.find_by(_id:BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    post :index, :keyword => 'curriculum 123 #$%@^&*()'
    # assert_not_nil !@curriculums.nil?
    assert_nil @curriculums
  end

  # Description: view list curriculum: mentor seach with curriculum_name input white spaces before, after curriculum name
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum with white spaces before, after curriculum_name" do
    @current_user = User.find_by(_id:BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    post :index, :keyword => '         curriculum 2                '
    assert_not_nil @curriculums
    # assert_nil @curriculums.nil?
  end

  # Description: view list curriculum: mentor seach with curriculum_name input only white spaces
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum with only white spaces" do
    @current_user = User.find_by(_id:BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    post :index, :keyword => '                        '
    assert_not_nil @curriculums
    # assert_nil @curriculums.nil?
  end

  # Description: view list curriculum: mentor seach with curriculum_name is value of curriculum exist
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum with curriculum_name is value of one curriculum" do
    @current_user = User.find_by(_id:BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    post :index, :keyword => 'curriculum 2 TV/Media/Newspaper'
    assert_not_nil @curriculums
    # assert_nil @curriculums.nil?
  end

  # Description: view list curriculum: mentor seach with curriculum_name isn't value of curriculum exist
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum with curriculum_name isn't value of one curriculum" do
    @current_user = User.find_by(_id:BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    post :index, :keyword => 'fhsdfieriidfnsjf fhsdfhsdfeiruei'
    # assert_not_nil !@curriculums.nil?
    assert_nil @curriculums
  end

  # Description: view list curriculum: mentor seach with curriculum_name is first word of curriculum exist
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum with curriculum_name is first word of one curriculum" do
    @current_user = User.find_by(_id:BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    post :index, :keyword => 'curriculum'
    assert_not_nil @curriculums
    # puts @curriculums
    # assert_nil @curriculums.nil?
  end

  # Description: view list curriculum: mentor seach with curriculum_name is middle word of curriculum exist
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "view list curriculum with curriculum_name is middle word of one curriculum" do
    @current_user = User.find_by(_id:BSON::ObjectId.from_string("5449dbc748757910f0070000"))
    get :index, :keyword => 'sales'
    assert_not_nil @curriculums
    # assert_nil @curriculums.nil?
  end

  test "requires authentication" do
    session[:user_id] = nil
    get :index
    assert_redirected_to signin_path
  end

end
