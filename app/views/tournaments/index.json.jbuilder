json.array!(@tournaments) do |tournament|
  json.extract! tournament, :id, :name, :game_id, :status, :randomized_teams
  json.url tournament_url(tournament, format: :json)
end
