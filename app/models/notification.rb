class Notification
  include Mongoid::Document
  include Mongoid::Timestamps

  #constant activity type
  COMMENT_TYPE = 'Comment'
  LIKE_TYPE = 'Like'

  #field
  field :activity_id, type: BSON::ObjectId
  field :activity_type, type: String
  field :object_id, type: BSON::ObjectId
  field :object_type, type: String
  field :unread, type: Boolean, default: TRUE
  field :content, type: String

  #relations
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'

  #indexes
  index({recipient_id: 1})
  index({object_id: 1, object_type: 1})
  index({created_at: -1})
  index({unread: 1})

  class << self
    # Description: This method count notifications by object
    # @param object_type, object_id, recipient_id, unread
    # @return
    # @throws Exception
    # @author HuyenDT
    # Create Date: 2014/12/05
    # Modify Date: 2014/12/05
    def get_notification_by_object_recipient(activity_type, object_type, object_ids, recipient_id, unread)
      notification_group = Notification.where(activity_type: activity_type, object_type: object_type, recipient_id: recipient_id, unread: unread).any_in(object_id: object_ids).group_by{|n| [n.object_id]}

      result = Hash.new
      notification_group.keys.each do |key|
        value = notification_group[key]
        # key_str = ""
        # key.each do |k|
        #   key_str = key_str + ' ' + k
        # end
        #
        # key_str = key_str.strip
        if value
          result[key[0]] = value.size
        end
      end

      result
    end
  end
end
