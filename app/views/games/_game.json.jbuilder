json.extract! game, :id, :game_title, :url, :created_at, :updated_at
json.url game_url(game, format: :json)