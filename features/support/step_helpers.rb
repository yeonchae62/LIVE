# frozen_string_literal: true

module StepHelpers
  def fetch_most_watched_game_titles
    # modify the following line if the most_watched games in the main_controller is changed
    ['Lost Recipes', 'Roboco', 'Zero Threat',
     'Arté: Hemut', 'Variant: Limits', 'Arté: Mercenas']
  end

  def expect_game_titles_in_order(expected_titles)
    game_links = all('.game_list_link')
    displayed_titles = game_links.map do |link|
      # Extract the text within the '.game_title' class within each link
      link.find('.game_title').text.strip
    end
    expect(displayed_titles).to eq(expected_titles)
  end
end
World(StepHelpers)
