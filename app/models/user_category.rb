class UserCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  #fields
  belongs_to :user
  belongs_to :category
  belongs_to :level

  # field :current_category,
  field :status, type: Integer

  #indexes
  index({user_id: 1})
  index({user_id: 1, category_id: 1})
  index({user_id: 1, category_id: 1, level_id: 1})

  #validates
  validates_presence_of :user_id
  validates_presence_of :category_id
  validates_presence_of :level_id
  validates_uniqueness_of :category_id, :scope => :user_id

  ITEM_PER_PAGE= 5

  class << self
    # Description: This method process get more roadmap
    # @param: user_id, last_roadmap_id
    # @return:
    # @throws Exception:
    # @author: HaPT
    # Create Date: 04/12/2014
    # Modify Date:
    def get_more_roadmaps(user_id,last_roadmap_id)
      if last_roadmap_id
        user_categories = UserCategory.where(user_id: user_id).lt(_id: last_roadmap_id).order_by(created_at: -1).limit(ITEM_PER_PAGE)
      else
        user_categories = UserCategory.where(user_id: user_id).order_by(created_at: -1).limit(ITEM_PER_PAGE)
      end
      user_categories
    end

    # Description: This method process get lastest roadmap
    # @param: user_id
    # @return:
    # @throws Exception:
    # @author: HaPT
    # Create Date: 04/12/2014
    # Modify Date:
    def get_lastest_roadmaps(user_id)
      UserCategory.where(user_id: user_id).order_by(created_at: -1).limit(ITEM_PER_PAGE)
    end

  end





end
