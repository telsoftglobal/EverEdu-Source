# Class Name: CurriculumStudyProgress
# Description: CurriculumStudyProgress model class, map to curriculum_study_progresses collection
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 21/11/2014
# Modify Date: 21/11/2014

class CurriculumStudyProgress
  include Mongoid::Document
  include Mongoid::Timestamps

  #fields
  field :curriculum_name, type: String
  field :start_date, type: DateTime, default: DateTime.now
  field :end_date, type: DateTime
  field :actual_start_date, type: DateTime
  field :actual_end_date, type: DateTime
  field :status, type: Integer, default: ProgressType::TO_DO
  field :note, type: String

  #attributes
  attr_accessor :material_total
  attr_accessor :material_done
  attr_accessor :action_total
  attr_accessor :action_done

  #relations
  belongs_to :curriculum
  belongs_to :student, class_name: 'User', foreign_key: :student_id
  has_many :material_study_progresses
  has_many :action_study_progresses

  #indexes
  index({curriculum_id: 1})
  index({student_id: 1})
  index({curriculum_id: 1, student_id: 1}, {unique: true})

  class << self
    # Description: search curriculum of mentor with pagination
    # @param: category_id, curriculum_name, mentor_id, page_number, item_per_page
    # @return:
    # @throws Exception:
    # @author: HaPT
    # Create Date: 15/11/2014
    # Modify Date:
    def search_with_pagination_by_student(curriculum_name, student_id, page_number, item_per_page)
      query = CurriculumStudyProgress.where(student_id: student_id)
      if !curriculum_name.nil? && !curriculum_name.blank?
        query = query.and(curriculum_name: /#{curriculum_name}/i)
      end
      curriculum_studies = query.order_by(start_date: -1).paginate(:page => page_number, :per_page => item_per_page)
      curriculum_studies
    end
    # Description: Get curriculum progresses of curriculum's student
    # @param: curriculum_id, student_id
    # @return material_study_progess collection
    # @throws Exception
    # @author SonNH
    # Create Date: 2014/12/04
    # Modify Date:
    def get_curriculum_study_by_id(curriculum_study_id)
      @curriculum_study = CurriculumStudyProgress.find_by(_id: curriculum_study_id)
      @curriculum_study
    end
    # Description: Get done material progresses of curriculum's student
    # @param: curriculum_id, student_id
    # @return material_study_progess collection
    # @throws Exception
    # @author SonNH
    # Create Date: 2014/12/03
    # Modify Date:
    def get_curriculum_study_curriculum_by_id(curriculum_id, student_id)
      @curriculum_study = CurriculumStudyProgress.where(curriculum_id: curriculum_id, student_id: student_id)[0]
      @curriculum_study
    end
  end

  # Description: calcutate total materials, done materials, total actions, done actions of curriculum
  # @param:
  # @return:
  # @throws Exception:
  # @author: HaPT
  # Create Date: 8/12/2014
  # Modify Date: 9/12/2014
  def calculate_progress
    self.material_total = 0
    self.material_done = 0
    self.action_total = 0
    self.action_done = 0
    self.material_study_progresses.each do |material|
      if material.parent_id.nil?
        self.material_total += 1
        if material.status.eql?ProgressType::DONE
          self.material_done += 1
        end
      end
    end

    self.action_total  = self.action_study_progresses.size()
    self.action_study_progresses.each do |action|
      if action.status.eql?ProgressType::DONE
        self.action_done += 1
      end
    end
  end

end
