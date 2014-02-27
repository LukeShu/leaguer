json.array!(@games) do |game|
  json.extract! game, :id, :name, :players_per_team, :teams_per_match, :set_rounds, :randomized_teams
  json.url game_url(game, format: :json)
end
