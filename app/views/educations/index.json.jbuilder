json.array!(@educations) do |education|
  json.extract! education, :id, :school_name, :start_year, :end_year, :current, :description
  json.url education_url(education, format: :json)
end
