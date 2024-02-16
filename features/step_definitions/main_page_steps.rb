# features/step_definitions/main_page_steps.rb

Given("I visit the main page") do
    visit root_path
  end
  
  Then("I should see {string}") do |content|
    expect(page).to have_content(content)
  end
  
  Then("I should see a link {string} leading to the login page") do |link_text|
    expect(page).to have_link(link_text, href: login_path)
  end
  
  