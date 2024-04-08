Given('I am on the games with dimensions page') do
    visit games_with_dimensions_path
  end
  
  Then('I should see the heading {string}') do |heading|
    expect(page).to have_css('h1', text: heading)
  end
  
  Then('I should see a link to return to main page') do
    expect(page).to have_link("Return to main", href: main_page_path)
  end
  
  Then('I should see a list of games with 3D contents') do
    expect(page).to have_css('h2', text: "All Games with 3D Contents")
    expect(page).to have_css('table tbody tr', count: Game.where(dimensions: "3D").count)
  end
  
  Then('I should see a list of games with 2D contents') do
    expect(page).to have_css('h2', text: "All Games with 2D Contents")
    expect(page).to have_css('table tbody tr', count: Game.where(dimensions: "2D").count)
  end
  
  Then('I should see a list of games needing further information') do
    expect(page).to have_css('h2', text: "All Games Needed Further Information")
    expect(page).to have_css('table tbody tr', count: Game.where(dimensions: nil).count)
  end
  