class HistoryJob
  include Mongoid::Document
  include Mongoid::Timestamps

  COMPANY_NAME_MAX_LENGTH = 100
  TITLE_MAX_LENGTH = 100
  LOCATION_MAX_LENGTH = 100
  DESCRIPTION_MAX_LENGTH = 2000

  field :company_name, type: String
  field :title, type: String
  field :location, type: String
  field :start_time, type: Date
  field :end_time, type: Date
  field :current, type: Mongoid::Boolean
  field :description, type: String

  #relationship
  belongs_to :user

  #indexs
  index({user_id: 1})
  index({user_id: 1,id:1})
  index({user_id: 1,title:1})
  index({user_id: 1,company_name:1})
  index({user_id: 1,title:1, company_name:1})

  #validates
  validates_length_of :company_name, maximum: COMPANY_NAME_MAX_LENGTH
  validates_length_of :title, maximum: TITLE_MAX_LENGTH
  validates_length_of :location, maximum: LOCATION_MAX_LENGTH
  validates_length_of :description, maximum: DESCRIPTION_MAX_LENGTH

  validates_presence_of :company_name, :title, :start_time, :user_id
  validates_presence_of :end_time, :if => "current.eql?(false)"

  validate :validate_date

  def validate_date
    if self.current
      self.end_time = nil
    end
    if !self.start_time.nil? && !self.end_time.nil? && end_time < start_time
      errors.add(:end_time, :greater_than_or_equal_to, :count => self.start_time)
    end

  end
end
