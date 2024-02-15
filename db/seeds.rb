# Seed the RottenPotatoes DB with some movies.
more_games = [
  {:game_title => 'test1', :url => 'https://test1.com'},
  {:game_title => 'test2', :url => 'https://test2.com'},
  {:game_title => 'test3', :url => 'https://test3.com'},
  {:game_title => 'test4', :url => 'https://test4.com'}
]

more_games.each do |game|
  Game.create!(game)
end