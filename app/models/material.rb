# Class Name: Material
# Description: Material model class
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 06/11/2014
# Modify Date: 06/11/2014

class Material
  include Mongoid::Document
  include Mongoid::Tree
  include Mongoid::Tree::Ordering
  include Mongoid::Timestamps

  #constanst
  NAME_MAX_LENGTH = 100
  URL_MAX_LENGTH = 500
  DESCRIPTION_MAX_LENGTH=10000



  #fields
  field :material_name, type: String
  field :material_url, type:	String
  field :description, type: String
  field :status, type: Integer, default: 1

  #relations
  #belongs_to :parent, class_name: self.name
  belongs_to :material_type
  belongs_to :curriculum

  #attributes
  attr_accessor :state

  #CuongCT 18-11-2014
  #validate
  validates_presence_of :material_name, :material_type
  validates_length_of :material_name, maximum: NAME_MAX_LENGTH
  # validates_length_of :description, maximum: DESCRIPTION_MAX_LENGTH
  validates_length_of :material_url, maximum: URL_MAX_LENGTH
  validates_format_of :material_url, :with => URI::regexp(%w(http https)), :allow_blank => true

  #indexes
  index({ material_type_id: 1 })
  index({ curriculum_id: 1 })
  index({ material_name: 1 })

  default_scope -> { order_by(id: 1)}

  #validate
  #validates_presence_of :material_name, :curriculum_id, :material_type_id, :status

  def object_type
    self.class.name
  end

  # Description: get lastest comment
  # @param:
  # @return:
  # @throws Exception:
  # @author: HuyenDT
  # Create Date: 01/12/2014
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
    self.curriculum.mentor
  end
end
