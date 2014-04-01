json.array!(@matches) do |match|
  json.extract! match, :id, :status, :tournament_id, :name, :winner_id, :remote_id
  json.url match_url(match, format: :json)
end
