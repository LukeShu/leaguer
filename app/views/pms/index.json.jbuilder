json.array!(@pms) do |pm|
  json.extract! pm, :id, :author_id, :recipient_id, :message, :subject, :conversation_id
  json.url pm_url(pm, format: :json)
end
