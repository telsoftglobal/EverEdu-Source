class Specialty
  include Mongoid::Document
  #include Mongoid::Timestamps

  SPECIALTY_MAX_LENGTH = 100
  DESCRIPTION_MAX_LENGTH = 2000

  #fields
  field :specialty, type: String
  field :years_of_experience, type: Integer
  field :description, type: String

  #relations
  #belongs_to :user

  embedded_in :user

  #validates
  validates_presence_of :specialty
  validates_length_of :specialty, maximum: SPECIALTY_MAX_LENGTH
  #validates_length_of :description, maximum: DESCRIPTION_MAX_LENGTH
  validates_numericality_of :years_of_experience, greater_than: 0, less_than: 100, allow_blank: true
  #validates_uniqueness_of :specialty, scope: :user, case_sensitive: false
  validates_uniqueness_of :specialty, case_sensitive: false

  #indexes
  #index({user_id: 1, specialty: 1}, {unique: true})
  #index({user_id: 1})
  index({'specialties.specialty' => 1})
end
