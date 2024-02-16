When("I visit the main page") do
  visit '/'
end

Then("I should see {string}") do |content|
  expect(page).to have_content(content)
end

Then("I should see a link {string} leading to the login page") do |link_text|
  expect(page).to have_link(link_text, href: '/login')
end

Then("I should see a search input field with placeholder {string}") do |placeholder|
  expect(page).to have_selector('input[type="text"][placeholder="' + placeholder + '"]')
end

Then("I should see a search button") do
  expect(page).to have_selector('button[type="submit"]')
end

Then("I should see six image containers") do
  expect(page).to have_selector('.image-container', count: 6)
end

Then("I should see a link {string} leading to the games page") do |link_text|
  expect(page).to have_link(link_text, href: '/games')
end
