# frozen_string_literal: true

Given('I am logged in to save a game') do
  @user = User.create(email: 'test@example.com', password: 'password')
  visit new_user_session_path
  fill_in 'Email', with: 'test@example.com'
  fill_in 'Password', with: 'password'
  click_link_or_button 'Log in'
end

And('I visit the games index page to save a game') do
  visit games_path
end

Given('{string} is in the index page') do |game_title|
  # Assuming the game "Game" is displayed on the index page
  # You may need to customize this step according to your application
  Game.create(game_title:)
end

And('I have not already saved the game {string}') do |game_title|
  # No specific action needed as we assume the game is not already saved
  game = Game.find_by(game_title:)
  user = User.first
  saved_game = SavedGame.find_by(user:, game:)
  expect(saved_game).to be_nil
end

And('I have already saved the game {string}') do |game_title|
  game = Game.find_by(game_title:)
  user = User.first
  SavedGame.create(user:, game:)
end

When('I click on the Save button for the game {string}') do |_game_title|
  click_link_or_button('Save')
end

Then('I should see that the game saved successfully!') do
  expect(page).to have_content('Game saved successfully!')
end

Then('I should see this game is already saved') do
  expect(page).to have_content('This game is already saved.')
end
