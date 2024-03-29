# frozen_string_literal: true

# features/step_definitions/user_management_steps.rb

Given('there are existing users') do
    @user1 = User.create(email: 'test1@example.com', password: 'password123')
    @user2 = User.create(email: 'test2@example.com', password: 'password123')
    @user3 = User.create(email: 'test3@example.com', password: 'password123')
end

When('I visit the user management page') do
    visit user_management_path
end

Then('I should see a list of all users') do
    User.all.each do |user|
      expect(page).to have_content(user.email)
    end
  end

When('I change the role of a user to admin') do
    @user1.update(role: 'admin')
end

Then('I should see user role as admin') do
    @user1.reload
    expect(@user1.role).to eq('admin')
end
 