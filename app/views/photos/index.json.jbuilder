json.array!(@photos) do |photo|
  json.extract! photo, :id, :author_id
  json.url photo_url(photo, format: :json)
end
