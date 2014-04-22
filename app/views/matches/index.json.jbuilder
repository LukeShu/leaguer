json.array!(@matches) do |match|
  json.extract! match, :id, :status, :tournament_stage_id, :winner_id, :remote_id, :submitted_peer_evaluations
  json.url match_url(match, format: :json)
end
