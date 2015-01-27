# Class Name: ActionStudyProgress
# Description: ActionStudyProgress model class, map to action_study_progresses collection
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 21/11/2014
# Modify Date: 21/11/2014

class ActionStudyProgress
  include Mongoid::Document
  include Mongoid::Timestamps

  #fields
  field :start_date, type: DateTime, default: DateTime.now
  field :end_date, type: DateTime
  field :actual_start_date, type: DateTime
  field :actual_end_date, type: DateTime
  field :status, type: Integer, default: ProgressType::TO_DO
  field :note, type: String

  #relations
  belongs_to :curriculum
  belongs_to :action
  belongs_to :student, class_name: 'User', foreign_key: :student_id
  belongs_to :curriculum_study_progress

  #indexes
  index({curriculum_id: 1})
  index({action_id: 1})
  index({student_id: 1})
  index({curriculum_id: 1, action_id: 1, student_id: 1}, {unique: true})

  default_scope -> { order_by(id: 1)}

  class << self

    # def get_total_action(curriculum_id, student_id)
    #   total_num = ActionStudyProgress.where(curriculum_id: curriculum_id, student_id: student_id).count()
    #   total_num
    # end
    #
    # def get_done_action(curriculum_id, student_id)
    #   done_num = ActionStudyProgress.where(curriculum_id: curriculum_id, student_id: student_id, status: 2).count()
    #   done_num
    # end
    # Description: Get actions progress of curriculum's student
    # @param: curriculum_id, student_id
    # @return action_study_progess collection
    # @throws Exception
    # @author SonNH
    # Create Date: 2014/12/03
    # Modify Date:
    def get_action_by_student_curriculum(curriculum_id, student_id)
      @actions = ActionStudyProgress.where(curriculum_id: curriculum_id, student_id: student_id)
      @actions
    end
    # Description: Get doneactions progress  of curriculum's student
    # @param: curriculum_id, student_id
    # @return action_study_progess  collection
    # @throws Exception
    # @author SonNH
    # Create Date: 2014/12/03
    # Modify Date:
    def get_action_done_by_student_curriculum(curriculum_id, student_id)
      @actions = ActionStudyProgress.where(curriculum_id: curriculum_id, student_id: student_id, status: 2)
      @actions
    end
  end

end
