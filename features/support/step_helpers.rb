# frozen_string_literal: true

module StepHelpers
  def fetch_most_watched_game_titles
    # modify the following line if the most_watched games in the main_controller is changed
    ['Lost Recipes', 'Roboco', 'Morning in Your Eyes',
     'Arté: Hemut', 'Variant: Limits', 'Arté: Mercenas']
  end

  def expect_game_titles_in_order(expected_titles)
    game_infos = all('.game-info')
    displayed_titles = game_infos.map do |info|
      info.find('p', text: /^Game Title:/).text.gsub('Game Title:', '').strip
    end
    expect(displayed_titles).to eq(expected_titles)
  end
end
World(StepHelpers)
