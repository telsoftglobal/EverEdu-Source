json.array!(@work_experiences) do |work_experience|
  json.extract! work_experience, :id, :work_place, :from_year, :to_year, :current, :description
  json.url work_experience_url(work_experience, format: :json)
end
