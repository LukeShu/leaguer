json.array!(@tournaments) do |tournament|
  json.extract! tournament, :id, :game_id
  json.url tournament_url(tournament, format: :json)
end
