require 'test_helper'

class MaterialStudyProgressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "insert a record" do
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum 1 TV/Media/Newspaper')
    user = User.find_by(user_name: 'hapt')
    curriculum.materials.each do |material|
      assert MaterialStudyProgress.create(curriculum_id: curriculum._id, student_id: user._id,material: material._id)
    end

  end

  test "get_progress_material" do
    progress = MaterialStudyProgress.get_progress_material(BSON::ObjectId.from_string("54648c27487579362b5c0300"),BSON::ObjectId.from_string("5461f725486150473f000000"))
    puts progress
  end
end
