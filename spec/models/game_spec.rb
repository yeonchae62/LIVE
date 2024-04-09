# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game do
  it 'is not valid without a title' do
    game = described_class.new(game_title: nil)
    expect(game).not_to be_valid
    expect(game.errors[:game_title]).to include("can't be blank")
  end

  # Currently code accepts blank URL due to CSV data having blank/invalid URLs
  # it 'is not valid without a url' do
  #   game = described_class.new(url: nil)
  #   expect(game).not_to be_valid
  #   expect(game.errors[:url]).to include("can't be blank")
  # end

  # Currently code accepts blank URL due to CSV data having blank/invalid URLs
  # it 'test url format' do
  #   game1 = described_class.create(game_title: 'Game1', url: 'https://game1.com')
  #   expect(game1).to be_valid
  #   game2 = described_class.new(game_title: 'Game2', url: 'httpgame2')
  #   expect(game2).not_to be_valid
  #   expect(game2.errors[:url]).to include('must be a valid URL')
  # end

  it 'is not valid with duplicated title' do
    described_class.create(game_title: 'Game1', url: 'https://game1.com')
    game2 = described_class.new(game_title: 'Game1')
    expect(game2).not_to be_valid
    expect(game2.errors[:game_title]).to include('already existed')
  end

  describe '.search_by_term' do
    let!(:game1) do
      described_class.create!(game_title: 'Match', source: 'Source1', dimensions: 'Dimensions1',
                              publication_year: 'Year1', generalized_subject: 'Subject')
    end
    let!(:game2) do
      described_class.create!(game_title: 'Game2', source: 'Another Match', dimensions: 'Dimensions2',
                              publication_year: 'Year2', generalized_subject: 'Subject')
    end
    let!(:game3) do
      described_class.create!(game_title: 'Game3', source: 'Source3', dimensions: 'Dimensions3',
                              publication_year: 'Year3', generalized_subject: 'Subject')
    end

    it 'includes games that match the search term' do
      results = described_class.search_by_term('%match%')
      expect(results).to include(game1, game2)
    end

    it 'excludes games that do not match the search term' do
      results = described_class.search_by_term('%match%')
      expect(results).not_to include(game3)
    end
  end

  describe '.order_relevance' do
    let(:search_term) { '%match%' }
    # Highest relevance
    let!(:game1) do
      described_class.create!(game_title: 'Match', source: 'Source1', dimensions: 'Dimensions1',
                              publication_year: 'Year1', generalized_subject: 'Subject')
    end
    # Lower relevance
    let!(:game2) do
      described_class.create!(game_title: 'Game2', source: 'Match', dimensions: 'Dimensions2',
                              publication_year: 'Year2', generalized_subject: 'Subject')
    end

    it 'orders games by highest relevance first' do
      ordered_games = described_class.order_relevance(search_term)
      expect(ordered_games.first).to eq(game1)
    end

    it 'includes lower relevance games in the order' do
      ordered_games = described_class.order_relevance(search_term)
      expect(ordered_games.second).to eq(game2)
    end
  end
end
