# features/step_definitions/user_validation_steps.rb

Given("I have a user with name {string} and email {string}") do |name, email|
    @user = User.new(name: name, email: email)
  end
  
  When("I check if the user is valid") do
    # No action needed here, as validation already happens in the RSpec tests
  end
  
  Then("the user should be valid") do
    expect(@user).to be_valid
  end
  
  Then("the user should not be valid") do
    expect(@user).not_to be_valid
  end
  