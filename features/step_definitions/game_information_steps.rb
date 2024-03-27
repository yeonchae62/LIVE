Given("I have a game {string} with the image_url {string}") do |game_title, image|
    # Create a game with the given title and image_url
    Game.create!(game_title: game_title, image: image)
  end
  
  
  When("I visit the game information page for {string}") do |game_title|
    # Visit the page that shows the information of the specified game
    game = Game.find_by(game_title: game_title)
    visit game_path(game)
  end
  
  Then("I should see an image for the game") do
    # Verify that an image is present for the game
    expect(page).to have_css('img')
  end
  
  Then("I should see a link to edit the game") do
    expect(page).to have_link('Edit this game')
  end
  
  Then("I should see a link to go back to the games list") do
    expect(page).to have_link('Back to games')
  end
  
