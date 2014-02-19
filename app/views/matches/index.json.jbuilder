json.array!(@matches) do |match|
  json.extract! match, :id, :tournament
  json.url match_url(match, format: :json)
end
