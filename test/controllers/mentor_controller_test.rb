require 'test_helper'

class MentorControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  # Description: show curriculum by user is author of curriculum
  # @author: HuyenDT
  # Create Date: 03/12/2014
  # Modify Date:
  test "get show by user is author of curriculum" do
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum 1')
    #user = User.find_by(user_name: 'student')

    get :show, {:id => curriculum.id}, {:user_id => curriculum.mentor.id}

    assert_equal assigns(:commentable), curriculum
    assert_response :success
  end

  # Description: show curriculum by user isn't author of curriculum
  # @author: HuyenDT
  # Create Date: 03/12/2014
  # Modify Date:
  test "get show by user isn't author of curriculum" do
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum 1')
    user = User.find_by(user_name: 'student')

    get :show, {:id => curriculum.id}, {:user_id => user.id}

    assert_equal flash[:error], I18n.t('msg_access_error')
  end

  # Description: update curriculum detail
  # @author: HuyenDT
  # Create Date: 03/12/2014
  # Modify Date:
  test "update curriculum detail" do
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum 1')
    user = curriculum.mentor
    object = curriculum
    object_id = object.id
    object_type = "curriculum"

    get :update_curriculum_detail, {:object_id => object_id, :object_type => object_type}, {:user_id => user.id}

    commentable = assigns[:commentable]
    expected_commentable = Curriculum.find_by(id: object_id)
    assert_equal commentable.id, expected_commentable.id

    notification_count = user.count_unread_notification(Notification::COMMENT_TYPE, object_id, object_type)
    assert_equal notification_count, 0, 'notification have not updated to read'
  end

  # Description: update material detail
  # @author: HuyenDT
  # Create Date: 03/12/2014
  # Modify Date:
  test "update material detail" do
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum 1')
    user = curriculum.mentor
    object = curriculum.materials[0]
    object_id = object.id
    object_type = "material"

    get :update_curriculum_detail, {:object_id => object_id, :object_type => object_type}, {:user_id => user.id}

    commentable = assigns[:commentable]
    expected_commentable = Material.find_by(id: object_id)
    assert_equal commentable.id, expected_commentable.id

    notification_count = user.count_unread_notification(Notification::COMMENT_TYPE, object_id, object_type)
    assert_equal notification_count, 0, 'notification have not updated to read'
  end

  # Description: update material detail
  # @author: HuyenDT
  # Create Date: 03/12/2014
  # Modify Date:
  test "update action detail" do
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum 1')
    user = curriculum.mentor
    object = curriculum.actions[0]
    object_id = object.id
    object_type = "action"

    get :update_curriculum_detail, {:object_id => object_id, :object_type => object_type}, {:user_id => user.id}

    commentable = assigns[:commentable]
    expected_commentable = Action.find_by(id: object_id)
    assert_equal commentable.id, expected_commentable.id

    notification_count = user.count_unread_notification(Notification::COMMENT_TYPE, object_id, object_type)
    assert_equal notification_count, 0, 'notification have not updated to read'
  end

end
