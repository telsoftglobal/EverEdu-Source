json.array!(@aes_actions) do |aes_action|
  json.extract! aes_action, :id
  json.url aes_action_url(aes_action, format: :json)
end
