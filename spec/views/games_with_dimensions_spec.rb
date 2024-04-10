# spec/views/games/dimensions_spec.rb

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'games/dimensions' do
  before do
    assign(:games_3d, Game.where(dimensions: ['3D']).order(dimensions: :desc))
    assign(:games_2d, Game.where(dimensions: ['2D']).order(dimensions: :asc))
    assign(:games_needing_updates, Game.where(dimensions: [nil]).order(game_title: :asc) +
                                   Game.where.not(dimensions: %w[2D 3D]).order(dimensions: :asc))
    render
  end

  it 'displays a link to return to the main page' do
    expect(rendered).to have_link('Return to main', href: main_page_path)
  end

  it 'displays 3D games' do
    expect(rendered).to have_css('h2', text: 'All Games with 3D Contents')
    expect(rendered).to have_table('3D-games')
  end

  it 'displays 2D games' do
    expect(rendered).to have_css('h2', text: 'All Games with 2D Contents')
    expect(rendered).to have_table('2D-games')
  end

  it 'displays games needing updates' do
    expect(rendered).to have_css('h2', text: 'All Games Needed Further Information')
    expect(rendered).to have_table('other-games')
  end
end
