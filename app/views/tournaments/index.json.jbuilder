json.array!(@tournaments) do |tournament|
  json.extract! tournament, :id, :game_id, :status, :name, :min_players_per_team, :max_players_per_team, :min_teams_per_match, :max_teams_per_match, :sampling_method, :scoring_method
  json.url tournament_url(tournament, format: :json)
end
