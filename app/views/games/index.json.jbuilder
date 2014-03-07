json.array!(@games) do |game|
  json.extract! game, :id, :name, :min_players_per_team, :max_players_per_team, :min_teams_per_match, :max_teams_per_match, :set_rounds, :randomized_teams
  json.url game_url(game, format: :json)
end
