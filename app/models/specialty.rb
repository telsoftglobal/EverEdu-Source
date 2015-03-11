class Specialty
  include Mongoid::Document
  include Mongoid::Timestamps

  SPECIALTY_MAX_LENGTH = 100
  DESCRIPTION_MAX_LENGTH = 200

  #fields
  field :specialty, type: String
  field :years_of_experience, type: Integer
  field :description, type: String

  #relations
  belongs_to :user

  #validates
  validates_presence_of :specialty
  validates_length_of :specialty, maximum: SPECIALTY_MAX_LENGTH
  validates_length_of :description, maximum: DESCRIPTION_MAX_LENGTH
  validates_numericality_of :years_of_experience, greater_than: 0, less_than: 100
  validates_uniqueness_of :specialty, scope: :user

  #indexes
  index({user_id: 1, specialty: 1}, {unique: true})
  index({user_id: 1})
end
