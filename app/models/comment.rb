class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  #constant define object types
  CURRICULUM_TYPE = "Curriculum"
  MATERIAL_TYPE = "Material"
  ACTION_TYPE = "Action"

  CONTENT_MAX_LENGTH = 5000
  COMMENT_PER_PAGE = 5

  #field
  field :author_info, type: Hash # {_id, user_name}
  field :object_id, type: BSON::ObjectId
  field :object_type, type: String
  field :content, type: String

  #relations
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :replies, :class_name => self.name, :foreign_key => :parent_id, :inverse_of => :parent, :validate => false
  belongs_to :parent, :class_name => self.name, :inverse_of => :replies, :index => true, :validate => false

  #indexes
  index({author_id: 1})
  index({object_id: 1, object_type: 1})
  index({created_at: -1})

  validates_presence_of :content, :object_id, :object_type
  validates_length_of :content, maximum: CONTENT_MAX_LENGTH

  class << self
    # Description: This method get more comments of commentable
    # @param: object_id, object_type, last_comment_id
    # @return: comment list
    # @throws Exception
    # @author HuyenDT
    # Create Date: 01/12/2014
    # Modify Date:

    def get_more_comments(object_id, object_type, last_comment_id)
      if last_comment_id
        comments = Comment.where(object_id: object_id, object_type: object_type, parent_id: nil).lt(_id: last_comment_id).order_by(created_at: -1).limit(COMMENT_PER_PAGE)
      else
        comments = Comment.where(object_id: object_id, object_type: object_type, parent_id: nil).order_by(created_at: -1).limit(COMMENT_PER_PAGE)
      end
      comments
    end

    def get_total_comments(object_id, object_type)
      Comment.where(object_id: object_id, object_type: object_type).count()
    end

  end
end
