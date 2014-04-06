json.array!(@servers) do |server|
  json.extract! server, :id, :default_user_permissions
  json.url server_url(server, format: :json)
end
