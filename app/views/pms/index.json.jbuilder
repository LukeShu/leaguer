json.array!(@pms) do |pm|
  json.extract! pm, :id, :author, :recipient, :message
  json.url pm_url(pm, format: :json)
end
