# Class Name: MaterialStudyProgress
# Description: MaterialStudyProgress model class, map to material_study_progresses collection
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 21/11/2014
# Modify Date: 03/12/2014

class MaterialStudyProgress
  include Mongoid::Document
  include Mongoid::Tree
  include Mongoid::Tree::Ordering
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
  belongs_to :material
  belongs_to :student, class_name: 'User', foreign_key: :student_id
  belongs_to :curriculum_study_progress

  #indexes
  index({curriculum_id: 1})
  index({material_id: 1})
  index({student_id: 1})

  default_scope -> { order_by(id: 1)}

  class << self
    # Description: Get total materials
    # @param: curriculum_id, student_id
    # @return
    # @throws Exception
    # @author HaPT
    # Create Date:
    # Modify Date:
    # def get_total_material(curriculum_id, student_id)
    #   total_num = MaterialStudyProgress.where(parent_id: nil,curriculum_id: curriculum_id, student_id: student_id).count()
    #   total_num
    # end

    # Description: Get done materials
    # @param: curriculum_id, student_id
    # @return
    # @throws Exception
    # @author HaPT
    # Create Date:
    # Modify Date:
    # def get_done_material(curriculum_id, student_id)
    #   done_num = MaterialStudyProgress.where(parent_id: nil,curriculum_id: curriculum_id, student_id: student_id, status: 2).count()
    #   done_num
    # end

    # Description: Get material progresses of curriculum's student
    # @param: curriculum_id, student_id
    # @return material_study_progess collection
    # @throws Exception
    # @author SonNH
    # Create Date: 2014/12/03
    # Modify Date:
    def get_material_by_student_curriculum(curriculum_id, student_id)
      @materials = MaterialStudyProgress.where(parent_id: nil,curriculum_id: curriculum_id, student_id: student_id)
      @materials
    end
    # Description: Get material progresses of curriculum's student
    # @param: curriculum_id, student_id
    # @return material_study_progess collection
    # @throws Exception
    # @author SonNH
    # Create Date: 2014/12/03
    # Modify Date:
    def get_material_by_curriculum_study(curriculum_study_id)
      @materials = MaterialStudyProgress.where(parent_id: nil,curriculum_study_progress_id: curriculum_study_id)
      @materials
    end
    # Description: Get material progresses of curriculum's student
    # @param: curriculum_id, student_id
    # @return material_study_progess collection
    # @throws Exception
    # @author SonNH
    # Create Date: 2014/12/03
    # Modify Date:
    def get_material_by_student_curriculum(curriculum_id, student_id)
      @materials = MaterialStudyProgress.where(parent_id: nil,curriculum_id: curriculum_id, student_id: student_id).order_by(material_id: 1)
      @materials
    end
    # Description: Get done material progresses of curriculum's student
    # @param: curriculum_id, student_id
    # @return material_study_progess collection
    # @throws Exception
    # @author SonNH
    # Create Date: 2014/12/03
    # Modify Date:
    def get_material_done_by_student_curriculum(curriculum_id, student_id)
      @materials = MaterialStudyProgress.where(parent_id: nil,curriculum_id: curriculum_id, student_id: student_id, status: 2)
      @materials
    end
    # Description: Get material progresses of curriculum's student
    # @param: curriculum_id, student_id
    # @return material_study_progess collection
    # @throws Exception
    # @author SonNH
    # Create Date: 2014/12/04
    # Modify Date:
    def get_material_study_by_id(material_study_id)
      @material = MaterialStudyProgress.find_by(_id: material_study_id)
      @material
    end


    # Description: Get root material progresses of curriculum's student
    # @param: curriculum_id, student_id
    # @return material_study_progess collection
    # @throws Exception
    # @author SonNH
    # Create Date: 2014/12/03
    # Modify Date:
    def get_root_material_by_student_curriculum(curriculum_id, student_id)
      @materials = MaterialStudyProgress.where(parent_id: nil,curriculum_id: curriculum_id, student_id: student_id)
      @materials
    end

  end
end
