Given("I am on the games with cost page") do
    visit games_with_cost_path
  end
  
  Then("I should see the heading {string}") do |heading|
    expect(page).to have_css('h1', text: heading)
  end
  
  Then("I should see a link to return to main page") do
    expect(page).to have_link("Return to main", href: main_page_path)
  end
  
  Then("I should see a list of free games") do
    expect(page).to have_css('h2', text: "Free Games")
    expect(page).to have_css('table tbody tr', count: Game.where(cost: "Free").count)
  end
  
  Then("I should see a list of games with cost information") do
    expect(page).to have_css('h2', text: "Games with Cost Information")
    expect(page).to have_css('table tbody tr', count: Game.where.not(cost: ["Free", nil]).count)
  end
  
  Then("I should see a list of games needing further updates") do
    expect(page).to have_css('h2', text: "Games need for further updates")
    expect(page).to have_css('table tbody tr', count: Game.where(cost: nil).count)
  end
  