class Avatar
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :description, type: String

  has_mongoid_attached_file :photo,
                            :styles => {
                                thumb: '100x100>',
                                square: '200x200#',
                                medium: '290x320>',
                                large: '465>'
                            }

  validates_attachment_presence :photo
  validates_attachment_content_type :photo, :content_type => %w(image/jpeg image/jpg image/png)
  validates_attachment_size :photo, :less_than => 3.megabytes
end
