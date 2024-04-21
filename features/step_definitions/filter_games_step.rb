# frozen_string_literal: true

When('I select the price range {string}') do |range|
  check "price_range_#{range}"
  click_on 'Search'
end

Then('I should see the following games:') do |table|
  table.raw.flatten.each do |title|
    expect(page).to have_content(title)
  end
end

When('I select the platform {string}') do |platform|
  check "platform_#{platform}"
  click_on 'Search'
end

When('I select the subject {string}') do |subject|
  check "subject_#{subject}"
  click_on 'Search'
end

When('I select the genre {string}') do |genre|
  check "genre_#{genre}"
  click_on 'Search'
end

When('I select the dimension {string}') do |dimension|
  check "dimensions_#{dimension}"
  click_on 'Search'
end

When('I select the other feature {string}') do |feature|
  check "other_features_#{feature}"
  click_on 'Search'
end
