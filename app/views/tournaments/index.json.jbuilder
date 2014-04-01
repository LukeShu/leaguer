json.array!(@tournaments) do |tournament|
  json.extract! tournament, :id, :name, :game_id, :status, :ger, :randomized_teams
  json.url tournament_url(tournament, format: :json)
end
