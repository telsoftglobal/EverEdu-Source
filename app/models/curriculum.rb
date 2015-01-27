# Class Name: Curriculum
# Description: Curriculum model class
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 06/11/2014
# Modify Date: 13/11/2014

class Curriculum
  include Mongoid::Document
  include Mongoid::Timestamps

  #constanst
  NAME_MAX_LENGTH = 100
  SUMMARY_MAX_LENGTH =200
  DESCRIPTION_MAX_LENGTH=10000


  #fields
  field :curriculum_name, type: String
  field :summary, type: String
  field :status, type: Integer, default: 1
  field :description, type: String

  #relations
  belongs_to :mentor, class_name: 'User', foreign_key: :mentor_id
  has_many :materials, :autosave => false
  has_many :actions, :autosave => false
  embeds_many :curriculum_categories

  #CuongCT 18-11-2014
  # accepts_nested_attributes_for :materials
  # accepts_nested_attributes_for :actions
   accepts_nested_attributes_for :curriculum_categories

  #CuongCT 18-11-2014
  #validate
  validates_presence_of :curriculum_name, :summary
  validates_length_of :curriculum_name, maximum: NAME_MAX_LENGTH
  validates_length_of :summary, maximum: SUMMARY_MAX_LENGTH
  # validates_length_of :description, maximum: DESCRIPTION_MAX_LENGTH
  # validates :materials,:curriculum_categories, :length => { :minimum => 1 }
  validate :validate_materials, :validate_curriculum_categories

  def object_type
    self.class.name
  end

  #validate atleast one material
  def validate_materials
    if !self.materials || self.materials.size == 0
        errors.add(:materials, :at_least_one, :count => 1)
    end
  end

  #validate atleast one material
  def validate_curriculum_categories
    if !self.curriculum_categories || self.curriculum_categories.size == 0
      errors.add(:curriculum_categories, :at_least_one, :count => 1)
    end
  end
  #indexs
  index({curriculum_name: 1})
  index({mentor_id: 1})
  index({status: 1})
  index({created_at: 1})
  index({'curriculum_categories.category_id' => 1})
  index({'curriculum_categories.category_id' => 1, 'curriculum_categories.level_ids' => 1})

  CATEGORIES_PER_ITEM=2

  class << self
    # Description: this method process searching curriculum with some conditions: category_id, level_id, curriculum_name
    # @param: category_id, level_id, keyword, page_number, item_per_page
    # @return: curriculum list
    # @throws Exception
    # @author HuyenDT
    # Create Date: 14/11/2014
    # Modify Date:
    def search(category_id, level_id, keyword, page_number, item_per_page)
      #category_id is require
      if !category_id.nil? && !category_id.is_a?(BSON::ObjectId)
        category_id = BSON::ObjectId.from_string(category_id)
      end
      query = Curriculum.where('curriculum_categories.category_id' => category_id)

      #level_id
      if !level_id.nil? && !level_id.blank?
        if !level_id.is_a?(BSON::ObjectId)
          level_id = BSON::ObjectId.from_string(level_id)
        end
        query = query.and('curriculum_categories.level_ids' => level_id)
      end

      #keyword category name
      if !keyword.nil? && !keyword.blank?
        query = query.and(curriculum_name: /#{keyword}/i)
      end

      #status
      query = query.and(status: 1)

      #order and paging
      curriculums = query.order_by(created_at: -1, curriculum_name: 1).paginate(:page => page_number, :per_page => item_per_page)

      #return search result
      curriculums
    end

    #Description: Get root materials of curriculum
    #param curriculum_id
    #return material collections
    #throws Exception
    #author SonNH
    #Create Date: 14/11/2014
    #Modify Date:
    def get_root_material(curriculum_id)
      materials = Material.where(parent_id: nil, curriculum_id: curriculum_id)
      materials
    end
    #Description: Get root materials of curriculum
    #param curriculum_id
    #return material collections
    #throws Exception
    #author SonNH
    #Create Date: 14/11/2014
    #Modify Date:
    def get_material_(curriculum_id)
      materials = Material.where(parent_id: nil, curriculum_id: curriculum_id)
      materials
    end

    #Description: Get root materials of curriculum
    #param curriculum_id
    #return material collections
    #throws Exception
    #author SonNH
    #Create Date: 14/11/2014
    #Modify Date:
    def get_root_material(curriculum_id)
      materials = Material.where(curriculum_id: curriculum_id, parent_id: nil).order_by(id: 1)
      materials
    end

    #Description: Get top 5 curriculum of mentor
    #param mentor_id
    #return curriculum collections
    #throws Exception
    #author SonNH
    #Create Date: 14/11/2014
    #Modify Date:
    def get_relative_material(curriculum_id)
      curriculum = Curriculum.where(curriculum_id: curriculum_id)
      curriculums = Curriculum.where(mentor_id: curriculum.mentor_id)
      curriculums
    end

    # Description: search curriculum of mentor with pagination
    # @param: category_id, curriculum_name, mentor_id, page_number, item_per_page
    # @return:
    # @throws Exception:
    # @author: HaPT
    # Create Date: 15/11/2014
    # Modify Date:
    def search_with_pagination_by_mentor(category_id, curriculum_name, mentor_id, page_number, item_per_page)
      query = Curriculum.where(mentor_id: mentor_id, status: 1) # initialization query with condition mentor_id
      if !category_id.nil? && !category_id.blank? #if category is chosen
        query = query.and("curriculum_categories.category_id" => BSON::ObjectId.from_string(category_id))# add condition with category_id
      end
      if !curriculum_name.nil? && !curriculum_name.blank? # if curriculum_name is not nil
        query = query.and(curriculum_name: /#{curriculum_name}/i) #add condition with curriculum_name
      end
      curriculums = query.order_by(created_at: -1, curriculum_name: 1).paginate(:page=>page_number, :per_page => item_per_page)

      curriculums
    end

    #Description: Update related information with curriculum
    #param
    #return
    #throws Exception
    #author HuyenDT
    #Create Date: 09/01/2015
    #Modify Date:
    def process_when_update_curriculum(curriculum)
      CurriculumStudyProgress.where(curriculum_id: curriculum.id).update_all(curriculum_name: curriculum.curriculum_name)
    end
  end

  # Description: get some category name to display on view list curriculum (description of curriculum)
  # @param:
  # @return:
  # @throws Exception:
  # @author: HaPT
  # Create Date: 15/11/2014
  # Modify Date:
  def get_some_category_name
    result = ''
    i = 0
    curriculum_categories.each do |category|
      if i.eql?0
        result += category.category_name
      else
        result += ','+category.category_name
      end
      i +=1
      if i.eql?CATEGORIES_PER_ITEM
        result += '...'
        break
      end
    end
    result
  end

  # # Description: validate at least one material
  # # @param:
  # # @return:
  # # @throws Exception:
  # # @author: CuongCT
  # # Create Date: 25/11/2014
  # # Modify Date:
  # private
  # def at_least_one_material
  #   unless disciplines.detect {|d| !d.marked_for_destruction? }
  #     errors.add(:disciplines, "must have at least one discipline")
  #   end
  # end

  # Description: get lastest comment
  # @param:
  # @return:
  # @throws Exception:
  # @author: HuyenDT
  # Create Date: 29/11/2014
  # Modify Date:
  def get_lastest_comments
     Comment.where(object_id: self.id, object_type: object_type, parent_id: nil).order_by(created_at: -1).limit(Comment::COMMENT_PER_PAGE)
  end

  # Description: get total comment
  # @param:
  # @return:
  # @throws Exception:
  # @author: HuyenDT
  # Create Date: 29/11/2014
  # Modify Date:
  def get_total_comments
    Comment.where(object_id: self.id, object_type: object_type).count()
  end

  def get_total_comments_not_reply
    Comment.where(object_id: self.id, object_type: object_type, parent_id: nil).count()
  end

  def get_author
    self.mentor
  end

  #Description: Get root materials of curriculum
  #param curriculum_id
  #return material collections
  #throws Exception
  #author SonNH
  #Create Date: 14/11/2014
  #Modify Date:
  def get_root_material
    Material.where(curriculum_id: id, parent_id: nil)
  end


end
