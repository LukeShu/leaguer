json.array!(@matches) do |match|
  json.extract! match, :id, :status, :tournament_stage_id, :winner_id
  json.url match_url(match, format: :json)
end
