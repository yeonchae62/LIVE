# features/step_definitions/create_user_account_steps.rb

Given("I am on the sign up page") do
    visit new_user_registration_path
  end
  
  When("I write in {string} with {string}") do |field, value|
    fill_in field, with: value
  end
  
  And("I press {string}") do |button|
    click_button button
  end
  
  Then("I shall see {string}") do |content|
    expect(page).to have_content(content)
  end

  Given("I am on the registration page") do
    visit new_user_registration_path
  end
  
  When("I fill in the registration form with valid data") do
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
  end
  
  And("I submit the registration form") do
    click_button 'Sign up'
  end

  Then("I should see a successful registration message") do
    expect(page).to have_content('Welcome to Our Website')
  end
  
  And("the user should have the default role") do
    user = User.last # Assuming the last created user is the one we just registered
    expect(user.role).to eq('user')
  end