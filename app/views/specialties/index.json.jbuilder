json.array!(@specialties) do |specialty|
  json.extract! specialty, :id, :specialty, :years_of_experience, :description
  json.url specialty_url(specialty, format: :json)
end
