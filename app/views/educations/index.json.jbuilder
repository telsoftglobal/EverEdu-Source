json.array!(@educations) do |education|
  json.extract! education, :id, :school_name, :String,, :school_url, :start_year, :graduation_year, :field_of_study, :grade, :activities_societies, :description
  json.url education_url(education, format: :json)
end
