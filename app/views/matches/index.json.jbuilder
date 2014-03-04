json.array!(@matches) do |match|
  json.extract! match, :id, :tournament_id, :name
  json.url match_url(match, format: :json)
end
