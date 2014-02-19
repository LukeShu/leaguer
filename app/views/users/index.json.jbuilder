json.array!(@users) do |user|
  json.extract! user, :id, :name, :pw_hash, :groups
  json.url user_url(user, format: :json)
end
