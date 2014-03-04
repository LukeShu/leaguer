json.array!(@alerts) do |alert|
  json.extract! alert, :id, :author_id, :message
  json.url alert_url(alert, format: :json)
end
