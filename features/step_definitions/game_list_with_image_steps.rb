Given("there are games with images") do
    # Create games with images
    Game.create!(game_title: "Game1", url: "http://example.com", image: "http://example.com/image1.jpg", platform: "Platform1")
    Game.create!(game_title: "Game2", url: "http://example.com", image: "http://example.com/image2.jpg", platform: "Platform2")
  end
  
  Given("there are games without images") do
    # Create games without images
    Game.create!(game_title: "Game3", url: "http://example.com", platform: "Platform3")
    Game.create!(game_title: "Game4", url: "http://example.com", platform: "Platform4")
  end
  
  When("I visit the games list page") do
    visit games_path
  end
  
  Then("I should see game information with images") do
    # Verify that game information with images is displayed
    expect(page).to have_css('.game .game-info .game-image')
  end
  
  Then("I should see game information without images") do
    # Verify that game information without images is displayed
    expect(page).to have_css('.game .game-info .game-image')
  end
  