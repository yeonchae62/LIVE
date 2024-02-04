class Game
  include Mongoid::Document
  include Mongoid::Timestamps
  field :game_title, type: String
  field :url, type: String
end
