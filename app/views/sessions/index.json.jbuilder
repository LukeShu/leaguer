json.array!(@sessions) do |session|
  json.extract! session, :id, :user_id, :token
  json.url session_url(session, format: :json)
end
