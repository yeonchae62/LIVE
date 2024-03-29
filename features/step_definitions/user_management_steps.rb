# frozen_string_literal: true

# features/step_definitions/user_management_steps.rb

Given('there are existing users') do
    @user = User.create(email: 'test1@example.com', password: 'password123')
    @user = User.create(email: 'test2@example.com', password: 'password123')
    @user = User.create(email: 'test3@example.com', password: 'password123')
end

When('I visit the user management page') do
    visit user_management_path
end

Then('I should see a list of all users') do
end