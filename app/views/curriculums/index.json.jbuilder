json.array!(@curriculums) do |curriculum|
  json.extract! curriculum, :id, :curriculum_name, :summary, :status, :description
  json.url curriculum_url(curriculum, format: :json)
end
