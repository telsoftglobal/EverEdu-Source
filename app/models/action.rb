# Class Name: Action
# Description: Action model class
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 06/11/2014
# Modify Date: 06/11/2014

class Action
  include Mongoid::Document
  include Mongoid::Timestamps

  #constanst
  NAME_MAX_LENGTH = 100
  DESCRIPTION_MAX_LENGTH=10000

  #fields
  field :action_name, type: String
  field :description, type: String
  field :status, type: Integer, default: 1

  #relations
  belongs_to :curriculum

  #CuongCT 18-11-2014
  #validate
  validates_presence_of :action_name
  validates_length_of :action_name, maximum: NAME_MAX_LENGTH
  # validates_length_of :description, maximum: DESCRIPTION_MAX_LENGTH
  #attributes
  attr_accessor :state

  #indexes
  index({ action_name: 1 }, { name: 'action_name_index' })
  index({ curriculum_id: 1 }, { name: 'curriculum_id_index' })

  default_scope -> { order_by(id: 1)}

  #validate
  validates_presence_of :action_name, :status

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
  # Create Date: 01/12/2014
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
