json.array!(@brackets) do |bracket|
  json.extract! bracket, :id, :user_id, :tournament_id, :name
  json.url bracket_url(bracket, format: :json)
end
