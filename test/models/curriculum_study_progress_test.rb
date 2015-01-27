require 'test_helper'

class CurriculumStudyProgressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "insert a record" do
    curriculum = Curriculum.find_by(curriculum_name: 'curriculum 2 Retail/Wholesale')
    user = User.find_by(user_name: 'hapt')
    assert curriculum_study_progress = CurriculumStudyProgress.create(curriculum_id: curriculum._id, student_id: user._id, curriculum_name: curriculum.curriculum_name)
    curriculum.materials.each do |material|
      assert MaterialStudyProgress.create(curriculum_id: curriculum._id, student_id: user._id,material: material._id, curriculum_study_progress_id: curriculum_study_progress._id)
    end
    curriculum.actions.each do |action|
      assert ActionStudyProgress.create(curriculum_id: curriculum._id, student_id: user._id,action: action._id, curriculum_study_progress_id: curriculum_study_progress._id)
    end
  end

  test "search by student" do
    # category_id : ObjectId("54648c27487579362b640300")
    # study_id : ObjectId("5461f725486150473f000000")
    curriculumstudyProgress = CurriculumStudyProgress.search_with_pagination_by_student('curriculum', BSON::ObjectId.from_string("5461f725486150473f000000"), 1, 2)
    curriculumstudyProgress.each do |curriculumstudy|
      puts curriculumstudy.curriculum.curriculum_name
      puts curriculumstudy.material_total
    end
  end
end
