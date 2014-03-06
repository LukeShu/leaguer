json.array!(@tournaments) do |tournament|
  json.extract! tournament, :id, :game_id, :min_players_per_team, :max_players_per_team, :min_teams_per_match, :max_teams_per_match, :set_rounds, :randomized_teams, :status
  json.url tournament_url(tournament, format: :json)
end
