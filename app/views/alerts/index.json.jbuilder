json.array!(@alerts) do |alert|
  json.extract! alert, :id, :author, :message
  json.url alert_url(alert, format: :json)
end
