require 'test_helper'

class StudentControllerTest < ActionController::TestCase
  # student_id: ObjectId("5461f725486150473f000000")

  # Description: view list curriculum: when student log in to system
  # @author: HaPT
  # Create Date: 26/11/2014
  # Modify Date:
  test "view all curriculums of student" do
    @current_user = User.find_by(user_name: 'hapt')
    session[:user_id] = @current_user.id
    get :index, {:page => 1}
    assert_response :success
    assert_not_nil assigns(:curriculums)
  end

  # Description: view list curriculum: student search with keyword
  # @author: HaPT
  # Create Date: 26/11/2014
  # Modify Date:
  test "search with key valid" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5461f725486150473f000000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => 'curriculum 2', :page => 1}
    assert_response :success
    assert_not_nil assigns(:curriculums)
  end

  # Description: view list curriculum: student search with curriculum_name only input special characters
  # @author: HaPT
  # Create Date: 26/11/2014
  # Modify Date:
  test "search with special characters" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5461f725486150473f000000"))
    session[:user_id] = @current_user._id
    get :index, {:category_id => '', :keyword => '&*()&^%$#', :page => 1}
    assert_response :success
    assert_nil assigns(:curriculums.nil?)
  end

  # Description: view list curriculum: student search with curriculum_name only input number
  # @author: HaPT
  # Create Date: 26/11/2014
  # Modify Date:
  test "view list curriculum when only enter curriculum_name with number only" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5461f725486150473f000000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => '12345', :page => 1}
    assert_response :success
    assert_nil assigns(:curriculums.nil?)
  end

  # Description: view list curriculum: student search with curriculum_name input alphanumeric characters and special characters
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  test "search with alphanumeric characters and special characters" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5461f725486150473f000000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => 'curriculum 123 #$%@^&*()', :page => 1}
    assert_response :success
    assert_nil assigns(:curriculums.nil?)
  end

  # Description: view list curriculum: student search with curriculum_name input white spaces before, after curriculum name
  # @author: HaPT
  # Create Date: 26/11/2014
  # Modify Date:
  test "search with white spaces before, after curriculum_name" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5461f725486150473f000000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => '         curriculum 2                ', :page => 1}
    assert_response :success
    assert_not_nil assigns(:curriculums)
  end

  # Description: view list curriculum: student search with curriculum_name input only white spaces
  # @author: HaPT
  # Create Date: 26/11/2014
  # Modify Date:
  test "search with only white spaces" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5461f725486150473f000000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => '                         ', :page => 1}
    assert_response :success
    assert_not_nil assigns(:curriculums)
  end

  # Description: view list curriculum: student search with curriculum_name is value of curriculum exist
  # @author: HaPT
  # Create Date: 26/11/2014
  # Modify Date:
  test "search curriculum_name is value of one curriculum" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5461f725486150473f000000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => 'curriculum 2 TV/Media/Newspaper', :page => 1}
    assert_response :success
    assert_not_nil assigns(:curriculums)
  end

  # Description: view list curriculum: student search with curriculum_name isn't value of curriculum exist
  # @author: HaPT
  # Create Date: 26/11/2014
  # Modify Date:
  test "view list curriculum with curriculum_name isn't value of one curriculum" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5461f725486150473f000000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => 'fhsdfieriidfnsjf fhsdfhsdfeiruei', :page => 1}
    assert_response :success
    assert_nil assigns(:curriculums.nil?)
  end

  # Description: view list curriculum: student search with curriculum_name is first word of curriculum exist
  # @author: HaPT
  # Create Date: 26/11/2014
  # Modify Date:
  test "view list curriculum with curriculum_name is first word of one curriculum" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5461f725486150473f000000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => 'curriculum', :page => 1}
    assert_response :success
    assert_not_nil assigns(:curriculums)
  end

  # Description: view list curriculum: student search with curriculum_name is middle word of curriculum exist
  # @author: HaPT
  # Create Date: 26/11/2014
  # Modify Date:
  test "search with curriculum_name is middle word of one curriculum" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5461f725486150473f000000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => 'TV', :page => 1}
    assert_response :success
    assert_not_nil assigns(:curriculums)
  end

  # Description: view list curriculum: student search with curriculum_name is Uper case
  # @author: HaPT
  # Create Date: 26/11/2014
  # Modify Date:
  test "search with curriculum_name is uper case" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("5461f725486150473f000000"))
    session[:user_id] = @current_user._id
    get :index, {:keyword => 'CURRICULUM', :page => 1}
    assert_response :success
    assert_not_nil assigns(:curriculums)
  end

  # Description: Check role student
  # @author: HaPT
  # Create Date: 26/11/2014
  # Modify Date:
  test "check role" do
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("54755d144d52531014010000"))
    session[:user_id] = @current_user._id
    get :index
    assert_redirected_to home
  end

  # Description: show curriculum by user is author of curriculum
  # @author: SonNH
  # Create Date: 04/12/2014
  # Modify Date:
  test "should show curriculum detail" do
    curriculum = Curriculum.find_by(curriculum_name: 'How to become a manager')
    @current_user = User.find_by(_id: BSON::ObjectId.from_string("54755d144d52531014010000"))
    get :show, {:id => curriculum.id}, {:user_id => @current_user.id}
    assert_response :success
  end
  # Description: update curriculum detail
  # @author: SonNH
  # Create Date: 03/12/2014
  # Modify Date: 13/12/2014
  test "update curriculum detail" do
    curriculum_study_progress=CurriculumStudyProgress.find_by(_id:"548bc2034d525300d0010000")
    object_id = curriculum_study_progress.id
    object_type = "curriculum"
    curriculum_id=curriculum_study_progress.id
    get :update_curriculum_detail, {:object_id => object_id, :object_type => object_type}, {:curriculum_id => curriculum_id}
    materials=curriculum_study_progress.material_study_progresses
    actions=curriculum_study_progress.action_study_progresses
    #assert
    assert_not_nil curriculum_study_progress,"curriculum is nil"
    assert_not_nil materials,"materials is nil"
    assert_not_nil actions,"actions is nil"
  end

  # Description: update material detail
  # @author: SonNH
  # Create Date: 03/12/2014
  # Modify Date: 13/12/2014
  test "update material detail" do
    material_study = MaterialStudyProgress.get_material_study_by_id("548576ab4d525313940f0000")
    object_id = material_study.id
    object_type = "material"
    curriculum_id=material_study.curriculum_study_progress_id
    get :update_curriculum_detail, {:object_id => object_id, :object_type => object_type}, {:curriculum_id => curriculum_id}
    #assert
    assert_not_nil material_study, "material_study is nil"

  end

  # Description: update material detail
  # @author: SonNH
  # Create Date: 03/12/2014
  # Modify Date: 13/12/2014
  test "update action detail" do
    action_study = ActionStudyProgress.find_by(_id: "548bc2034d525300d0080000")
    object_id = action_study.id
    object_type = "action"
    curriculum_id = action_study.curriculum_study_progress_id
    get :update_curriculum_detail, {:object_id => object_id, :object_type => object_type}, {:curriculum_id => curriculum_id}
    #assert
    assert_not_nil action_study, "action_study is nil"
  end
  # Description: start study curriculum
  # @author: SonNH
  # Create Date: 13/12/2014
  # Modify Date:
  test "start study curriculum" do
    curriculum_study_progress=CurriculumStudyProgress.find_by(_id:"548bc2034d525300d0010000")
    object = curriculum_study_progress.curriculum
    object_id = curriculum_study_progress.id
    object_type = "curriculum"
    curriculum_id=curriculum_study_progress.id
    status=ProgressType::IN_PROGRESS
    get :update_menu_right, {:object_id => object_id, :object_type => object_type}, {:curriculum_id => curriculum_id}, {:status => status}
    assert curriculum_study_progress.update_attributes(:actual_start_date => DateTime.now) ,"Update actual_start_date is fail"
    assert curriculum_study_progress.update_attributes(:status=> status) ,"Update status is fail"
  end
  # Description: done study detail
  # @author: SonNH
  # Create Date: 13/12/2014
  # Modify Date:
  test "done study curriculum" do
    curriculum_study_progress=CurriculumStudyProgress.find_by(_id:"548bc2034d525300d0010000")
    object = curriculum_study_progress.curriculum
    object_id = curriculum_study_progress.id
    object_type = "curriculum"
    curriculum_id=curriculum_study_progress.id
    status=ProgressType::DONE
    get :update_menu_right, {:object_id => object_id, :object_type => object_type}, {:curriculum_id => curriculum_id}, {:status => status}
    assert curriculum_study_progress.update_attributes(:actual_end_date => DateTime.now) ,"Update actual_start_date is fail"
    assert curriculum_study_progress.update_attributes(:status=> status) ,"Update status is fail"
  end
  # Description: start study material
  # @author: SonNH
  # Create Date: 13/12/2014
  # Modify Date:
  test "start study material" do
    material_study = MaterialStudyProgress.get_material_study_by_id("548576ab4d525313940f0000")
    object_id = material_study.id
    object_type = "material"
    curriculum_id=material_study.curriculum_study_progress_id
    status=ProgressType::IN_PROGRESS
    get :update_menu_right, {:object_id => object_id, :object_type => object_type}, {:curriculum_id => curriculum_id}, {:status => status}
    assert material_study.update_attributes(:actual_start_date => DateTime.now) ,"Update actual_start_date is fail"
    assert material_study.update_attributes(:status=> status) ,"Update status is fail"
  end
  # Description: done study material
  # @author: SonNH
  # Create Date: 13/12/2014
  # Modify Date:
  test "done study material" do
    material_study = MaterialStudyProgress.get_material_study_by_id("548576ab4d525313940f0000")
    object_id = material_study.id
    object_type = "material"
    curriculum_id=material_study.curriculum_study_progress_id
    status=ProgressType::DONE
    get :update_menu_right, {:object_id => object_id, :object_type => object_type}, {:curriculum_id => curriculum_id}, {:status => status}
    assert material_study.update_attributes(:actual_start_date => DateTime.now) ,"Update actual_start_date is fail"
    assert material_study.update_attributes(:status=> status) ,"Update status is fail"
  end
  # Description: start action
  # @author: SonNH
  # Create Date: 13/12/2014
  # Modify Date:
  test "start study action" do
    action_study = ActionStudyProgress.find_by(_id: "548bc2034d525300d0080000")
    object_id = action_study.id
    object_type = "action"
    curriculum_id = action_study.curriculum_study_progress_id
    status=ProgressType::IN_PROGRESS
    get :update_menu_right, {:object_id => object_id, :object_type => object_type}, {:curriculum_id => curriculum_id}, {:status => status}
    assert action_study.update_attributes(:actual_start_date => DateTime.now) ,"Update actual_start_date is fail"
    assert action_study.update_attributes(:status=> status) ,"Update status is fail"
  end
  # Description: start action
  # @author: SonNH
  # Create Date: 13/12/2014
  # Modify Date:
  test "done study action" do
    action_study = ActionStudyProgress.find_by(_id: "548bc2034d525300d0080000")
    object_id = action_study.id
    object_type = "action"
    curriculum_id = action_study.curriculum_study_progress_id
    status=ProgressType::DONE
    get :update_menu_right, {:object_id => object_id, :object_type => object_type}, {:curriculum_id => curriculum_id}, {:status => status}
    assert action_study.update_attributes(:actual_start_date => DateTime.now) ,"Update actual_start_date is fail"
    assert action_study.update_attributes(:status=> status) ,"Update status is fail"
  end
end
