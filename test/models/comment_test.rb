require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "insert comment" do
    user = User.find_by(user_name: 'huyendt')
    curriculum = Curriculum.find_by(curriculum_name: 'Test join 1 updated updated updated')

    for i in 0..10000
      comment = Comment.new
      comment.author_info = {_id: user.id, user_name: user.user_name}
      comment.author = user
      comment.commentable_id = curriculum.id
      comment.commentable_type = Comment::CURRICULUM_TYPE
      comment.content = "#{i}"
      assert comment.save
    end
  end

  test "insert reply" do
    user = User.find_by(user_name: 'cant')
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum1')
    comments = Comment.where(content: /how to become to mentor/)

    comments.each do |comment|
      for i in 0..2
        reply = Comment.new
        reply.author_info = {_id: user.id, user_name: user.user_name}
        reply.author = user
        reply.object_id = curriculum.id
        reply.object_type = Comment::CURRICULUM_TYPE
        reply.content = "reply #{comment.content} #{i}"
        reply.parent = comment
        assert reply.save
      end
    end


  end

  test "find comment" do
    comments = Comment.where(parent_id: nil, "author_info.user_name" => 'huyendt')
    comments.each do |comment|
      puts comment.author_info['_id']
      puts comment.author_info['user_name']
      puts comment.content
    end
  end
end
