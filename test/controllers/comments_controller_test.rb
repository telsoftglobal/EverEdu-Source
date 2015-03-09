require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  # Description: created new comment by student
  # @author: HuyenDT
  # Create Date: 03/12/2014
  # Modify Date:
  test "create new comment for curriculum by student successfully" do
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum 1')
    object_id = curriculum.id
    object_type = curriculum.object_type
    comment = 'comment-student1'
    user = User.find_by(user_name: 'student')

    #delete old data
    Comment.delete_all(object_id: curriculum.id, object_type: curriculum.object_type, author_id: user.id, content: comment)
    Notification.find_by(activity_type: Notification::COMMENT_TYPE, object_id: curriculum.id, object_type: curriculum.object_type, unread: TRUE, recipient_id: curriculum.mentor.id)

    post :create,  {:object_id => object_id, :object_type => object_type, :comment => comment},  {:user_id => user.id}

    new_comment = assigns(:comment)
    expected_comment = Comment.find_by(object_id: curriculum.id, object_type: curriculum.object_type, author_id: user.id, content: comment )

    assert_equal new_comment, expected_comment

    notification = Notification.find_by(activity_id: expected_comment.id, activity_type: Notification::COMMENT_TYPE, object_id: curriculum.id, object_type: curriculum.object_type, unread: TRUE, recipient_id: curriculum.mentor.id)
    assert_not_nil notification
  end

  # Description: created new comment by mentor
  # @author: HuyenDT
  # Create Date: 03/12/2014
  # Modify Date:
  test "create new comment for curriculum by mentor successfully" do
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum 1')
    object_id = curriculum.id
    object_type = curriculum.object_type
    comment = 'comment-mentor1'
    user = curriculum.mentor

    #delete old data
    Comment.delete_all(object_id: curriculum.id, object_type: curriculum.object_type, author_id: user.id, content: comment)
    Notification.find_by(activity_type: Notification::COMMENT_TYPE, object_id: curriculum.id, object_type: curriculum.object_type, unread: TRUE, recipient_id: curriculum.mentor.id)

    post :create,  {:object_id => object_id, :object_type => object_type, :comment => comment},  {:user_id => user.id}

    new_comment = assigns(:comment)
    expected_comment = Comment.find_by(object_id: curriculum.id, object_type: curriculum.object_type, author_id: user.id, content: comment )

    assert_equal new_comment, expected_comment

    notification = Notification.find_by(activity_id: expected_comment.id, activity_type: Notification::COMMENT_TYPE, object_id: curriculum.id, object_type: curriculum.object_type, unread: TRUE, recipient_id: curriculum.mentor.id)
    assert_nil notification
  end

  # Description: created new comment for material by student
  # @author: HuyenDT
  # Create Date: 03/12/2014
  # Modify Date:
  test "create new comment for material by student successfully" do
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum 1')
    object = curriculum.materials[0]
    object_id = object.id
    object_type = object.object_type
    comment = 'material comment-student1'
    user = User.find_by(user_name: 'student')

    #delete old data
    Comment.delete_all(object_id: object.id, object_type: object.object_type, author_id: user.id, content: comment)
    Notification.find_by(activity_type: Notification::COMMENT_TYPE, object_id: object.id, object_type: object.object_type, unread: TRUE, recipient_id: curriculum.mentor.id)

    post :create,  {:object_id => object_id, :object_type => object_type, :comment => comment},  {:user_id => user.id}

    new_comment = assigns(:comment)
    expected_comment = Comment.find_by(object_id: object.id, object_type: object.object_type, author_id: user.id, content: comment )

    assert_equal new_comment, expected_comment

    notification = Notification.find_by(activity_id: expected_comment.id, activity_type: Notification::COMMENT_TYPE, object_id: object.id, object_type: object.object_type, unread: TRUE, recipient_id: curriculum.mentor.id)
    assert_not_nil notification
  end

  # Description: created new comment for material by mentor
  # @author: HuyenDT
  # Create Date: 03/12/2014
  # Modify Date:
  test "create new comment for material by mentor successfully" do
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum 1')
    object = curriculum.materials[0]
    object_id = object.id
    object_type = object.object_type
    comment = 'material comment-mentor1'
    user = curriculum.mentor

    #delete old data
    Comment.delete_all(object_id: object.id, object_type: object.object_type, author_id: user.id, content: comment)
    Notification.find_by(activity_type: Notification::COMMENT_TYPE, object_id: object.id, object_type: object.object_type, unread: TRUE, recipient_id: curriculum.mentor.id)

    post :create,  {:object_id => object_id, :object_type => object_type, :comment => comment},  {:user_id => user.id}

    new_comment = assigns(:comment)
    expected_comment = Comment.find_by(object_id: object.id, object_type: object.object_type, author_id: user.id, content: comment )

    assert_equal new_comment, expected_comment

    notification = Notification.find_by(activity_id: expected_comment.id, activity_type: Notification::COMMENT_TYPE, object_id: object.id, object_type: object.object_type, unread: TRUE, recipient_id: curriculum.mentor.id)
    assert_not notification
  end

  # Description: created new comment for action by student
  # @author: HuyenDT
  # Create Date: 03/12/2014
  # Modify Date:
  test "create new comment for action by student successfully" do
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum 1')
    object = curriculum.actions[0]
    object_id = object.id
    object_type = object.object_type
    comment = 'action comment-student1'
    user = User.find_by(user_name: 'student')

    #delete old data
    Comment.delete_all(object_id: object.id, object_type: object.object_type, author_id: user.id, content: comment)
    Notification.find_by(activity_type: Notification::COMMENT_TYPE, object_id: object.id, object_type: object.object_type, unread: TRUE, recipient_id: curriculum.mentor.id)

    post :create,  {:object_id => object_id, :object_type => object_type, :comment => comment},  {:user_id => user.id}

    new_comment = assigns(:comment)
    expected_comment = Comment.find_by(object_id: object.id, object_type: object.object_type, author_id: user.id, content: comment )

    assert_equal new_comment, expected_comment

    notification = Notification.find_by(activity_id: expected_comment.id, activity_type: Notification::COMMENT_TYPE, object_id: object.id, object_type: object.object_type, unread: TRUE, recipient_id: curriculum.mentor.id)
    assert_not_nil notification
  end


  # Description: created new comment for action by student
  # @author: HuyenDT
  # Create Date: 03/12/2014
  # Modify Date:
  test "create new comment for action by mentor successfully" do
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum 1')
    object = curriculum.actions[0]
    object_id = object.id
    object_type = object.object_type
    comment = 'action comment-mentor1'
    user = curriculum.mentor

    #delete old data
    Comment.delete_all(object_id: object.id, object_type: object.object_type, author_id: user.id, content: comment)
    Notification.find_by(activity_type: Notification::COMMENT_TYPE, object_id: object.id, object_type: object.object_type, unread: TRUE, recipient_id: curriculum.mentor.id)

    post :create,  {:object_id => object_id, :object_type => object_type, :comment => comment},  {:user_id => user.id}

    new_comment = assigns(:comment)
    expected_comment = Comment.find_by(object_id: object.id, object_type: object.object_type, author_id: user.id, content: comment )

    assert_equal new_comment, expected_comment

    notification = Notification.find_by(activity_id: expected_comment.id, activity_type: Notification::COMMENT_TYPE, object_id: object.id, object_type: object.object_type, unread: TRUE, recipient_id: curriculum.mentor.id)
    assert_not notification
  end


  # Description: create new comment with only whitespace
  # @author: HuyenDT
  # Create Date: 03/12/2014
  # Modify Date:
  test "create new comment with only whitespace" do
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum 1')
    object = curriculum
    object_id = object.id
    object_type = object.object_type
    comment = '                     '
    user = User.find_by(user_name: 'student')

    #delete old data
    Comment.delete_all(object_id: object.id, object_type: object.object_type, author_id: user.id, content: comment)
    Notification.find_by(activity_type: Notification::COMMENT_TYPE, object_id: object.id, object_type: object.object_type, unread: TRUE, recipient_id: curriculum.mentor.id)

    post :create,  {:object_id => object_id, :object_type => object_type, :comment => comment},  {:user_id => user.id}

    assert assigns(:comment).errors[:comment]
    comment = Comment.find_by(object_id: object.id, object_type: object.object_type, author_id: user.id, content: comment )

    assert_nil comment
  end

  # Description: create new comment with whitespace at the begin and at the end
  # @author: HuyenDT
  # Create Date: 03/12/2014
  # Modify Date:
  test "create new comment with whitespace at the begin and at the end" do
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum 1')
    object = curriculum
    object_id = object.id
    object_type = object.object_type
    comment = '  abc '
    user = User.find_by(user_name: 'student')

    #delete old data
    Comment.delete_all(object_id: object.id, object_type: object.object_type, author_id: user.id, content: comment.strip)
    Notification.find_by(activity_type: Notification::COMMENT_TYPE, object_id: object.id, object_type: object.object_type, unread: TRUE, recipient_id: curriculum.mentor.id)

    post :create,  {:object_id => object_id, :object_type => object_type, :comment => comment},  {:user_id => user.id}

    new_comment = assigns(:comment)
    expected_comment = Comment.find_by(object_id: object.id, object_type: object.object_type, author_id: user.id, content: comment.strip )

    assert_equal new_comment, expected_comment

  end

  # Description: create new comment with only whitespace
  # @author: HuyenDT
  # Create Date: 03/12/2014
  # Modify Date:
  test "create new comment with max length" do
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum 1')
    object = curriculum
    object_id = object.id
    object_type = object.object_type
    comment = ''
    for i in 1..5001
      comment = comment + 'a'
    end
    user = User.find_by(user_name: 'student')

    #delete old data
    Comment.delete_all(object_id: object.id, object_type: object.object_type, author_id: user.id, content: comment)
    Notification.find_by(activity_type: Notification::COMMENT_TYPE, object_id: object.id, object_type: object.object_type, unread: TRUE, recipient_id: curriculum.mentor.id)

    post :create,  {:object_id => object_id, :object_type => object_type, :comment => comment},  {:user_id => user.id}

    assert assigns(:comment).errors[:comment]
    comment = Comment.find_by(object_id: object.id, object_type: object.object_type, author_id: user.id, content: comment )

    assert_nil comment
  end

  # Description: get more comments successful
  # @author: HuyenDT
  # Create Date: 03/12/2014
  # Modify Date:
  test "get more comments successful" do
    user = User.find_by(user_name: 'student')
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum 1')
    object = curriculum
    object_id = object.id
    object_type = object.object_type
    lastest_comments = Comment.where(object_id: object.id, object_type: object.object_type).order_by(created_at: -1).limit(Comment::COMMENT_PER_PAGE)
    last_comment_id = nil

    lastest_comments.each do |comment|
      last_comment_id = comment.id
    end


    get :get_more_comments,  {:object_id => object_id, :object_type => object_type, :last_comment_id => last_comment_id},  {:user_id => user.id}

    comments = assigns(:comments)
    expected_comments = Comment.where(object_id: object.id, object_type: object.object_type, parent_id: nil).lt(_id: last_comment_id).order_by(created_at: -1).limit(Comment::COMMENT_PER_PAGE)

    assert_equal comments, expected_comments
  end
end
