class Education
  include Mongoid::Document
  field :school_name, type: String
  field :school_url, type: String
  field :start_year, type: Integer
  field :graduation_year, type: Integer
  field :field_of_study, type: String
  field :grade, type: String
  field :activities_societies, type: String
  field :description, type: String

  belongs_to :app_param
  embedded_in :user
end
