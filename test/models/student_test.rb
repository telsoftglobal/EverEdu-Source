require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # Description: Test view detail of curriculum: when mentor click Read more
  # @author: SonNH
  # Create Date: 04/12/2014
  # Modify Date:
  test "should show curriculum detail" do
    @curriculum_study_progress=CurriculumStudyProgress.find_by(_id:"547fd42e4d52530cb0000000")
    assert_not_nil @curriculum_study_progress,"curriculum is nil"
    assert_not_nil @curriculum_study_progress.material_study_progresses,"materials are nil"
    assert_not_nil @curriculum_study_progress.action_study_progresses,"actions are nil"
  end
  # Description: Update status of curriculum
  # @author: SonNH
  # Create Date: 04/12/2014
  # Modify Date:
  test "update status of curriculum" do
      @curriculum_study_progress=CurriculumStudyProgress.find_by(_id:"547fd42e4d52530cb0000000")
      @status=='1'
      #Update curriculum
      if @status=='2'
        #Update all material
        materials=@curriculum_study_progress.material_study_progresses
        materials.each do |material|
          material.children.each do |child|
            child.update_attributes(:status => @status)
          end
          material.update_attributes(:status => @status)
        end
        #Update all action
        actions=@curriculum_study_progress.action_study_progresses
        actions.each do |action|
          action.update_attributes(:status => @status)
        end
      end
      @curriculum_study_progress.update_attributes(:status => @status)
  end
  # Description: Update status of material
  # @author: SonNH
  # Create Date: 04/12/2014
  # Modify Date:
  test "update status of material" do
    @status=='2'
    @material_study= MaterialStudyProgress.get_material_study_by_id("547fd42e4d52530cb0010000")
    if @status=='1'
      @curriculum_study_progress=@material_study.curriculum
      @curriculum_study_progress.update_attributes(:status => @status)
    end
    #Update status of material
    if @status=='2'
      @material_study.children.each do |child|
        child.update_attributes(:status => @status)
      end
    end
    @material_study.update_attributes(:status => @status)
  end
  # Description: Test for update status of action
  # @author: SonNH
  # Create Date: 04/12/2014
  # Modify Date:
  test "update status of action" do
    @action_study=ActionStudyProgress.find_by(_id: "547fd42e4d52530cb0050000")
    @curriculum_study_progress=@action_study.curriculum
    @status=='2'
    if @status=='1'
      @curriculum_study_progress.update_attributes(:status => @status)
    end
    @action_study.update_attributes(:status => @status)
  end
  end

