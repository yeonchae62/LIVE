Given("I am logged in to save a game") do
    @user = User.create(email: "test@example.com", password: "password")
    visit new_user_session_path
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    click_button "Log in"
  end
  
  When("I visit the games index page to save a game") do
    visit games_path
  end
  
  And("I click on the Save button for game {string}") do |game_title|
    game = Game.find_by(game_title: game_title)
    within('.games-info') do
      click_link("Save", href: saved_games_path(game_id: game.id))
    end
  end
  
  Then("I should see a success message {string}") do |message|
    expect(page).to have_content message
  end
  
  And("I should see the game in my saved games list") do
    visit saved_games_path
    expect(page).to have_content(game_title)
  end
  