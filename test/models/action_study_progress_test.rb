require 'test_helper'

class ActionStudyProgressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "insert a record" do
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum 1 TV/Media/Newspaper')
    user = User.find_by(user_name: 'hapt')
    curriculum.actions.each do |action|
      assert ActionStudyProgress.create(curriculum_id: curriculum._id, student_id: user._id,action: action._id)
    end

  end

  test "get_progress_action" do
    progress = ActionStudyProgress.get_progress_action(BSON::ObjectId.from_string("54648c27487579362b5c0300"),BSON::ObjectId.from_string("5461f725486150473f000000"))
    puts progress
  end
end
