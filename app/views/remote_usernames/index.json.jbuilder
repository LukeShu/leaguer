json.array!(@remote_usernames) do |remote_username|
  json.extract! remote_username, :id, :game_id, :user_id, :user_name
  json.url remote_username_url(remote_username, format: :json)
end
