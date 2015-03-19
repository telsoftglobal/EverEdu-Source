class Education
  include Mongoid::Document

  SCHOOL_NAME_MAX_LENGTH = 100
  URL_MAX_LENGTH = 500
  FIELD_OF_STUDY_MAX_LENGTH = 100
  GRADE_MAX_LENGTH = 80
  ACTIVITIES_SOCIETIES_MAX_LENGTH = 500
  DESCRIPTION_MAX_LENGTH = 1000

  field :school_name, type: String
  field :school_url, type: String
  field :start_year, type: Integer
  field :graduation_year, type: Integer
  field :field_of_study, type: String
  field :grade, type: String
  field :activities_societies, type: String
  field :description, type: String

  # belongs_to :app_param
  belongs_to :degree, class_name: 'AppParam', :foreign_key => 'degree_id'
  embedded_in :user

  #index
  index({'educations.school_name' => 1})

  #validates
  validates_length_of :school_name, maximum: SCHOOL_NAME_MAX_LENGTH
  validates_length_of :school_url, maximum: URL_MAX_LENGTH
  validates_length_of :field_of_study, maximum: FIELD_OF_STUDY_MAX_LENGTH
  validates_length_of :grade, maximum: GRADE_MAX_LENGTH
  validates_length_of :activities_societies, maximum: ACTIVITIES_SOCIETIES_MAX_LENGTH
  validates_length_of :description, maximum: DESCRIPTION_MAX_LENGTH

  validates_presence_of :school_name
  validates_numericality_of :start_year, only_integer: true, greater_than_or_equal_to: 1905, less_than_or_equal_to: Time.now.year, allow_blank: true
  validates_numericality_of :graduation_year, only_integer: true, greater_than_or_equal_to: 1905, less_than_or_equal_to: Time.now.year + 10, allow_blank: true

  validate :validate_date
  def validate_date
    if !self.start_year.nil? && !self.graduation_year.nil? && graduation_year < start_year
      errors.add(:graduation_year, :greater_than_or_equal_to, :count => self.start_year)
    end

  end
end
