# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game do
  it 'is not valid without a title' do
    game = described_class.new(game_title: nil)
    expect(game).not_to be_valid
    expect(game.errors[:game_title]).to include("can't be blank")
  end

  it 'is not valid without a url' do
    game = described_class.new(url: nil)
    expect(game).not_to be_valid
    expect(game.errors[:url]).to include("can't be blank")
  end

  it 'test url format' do
    game1 = described_class.create(game_title: 'Game1', url: 'https://game1.com')
    expect(game1).to be_valid
    game2 = described_class.new(game_title: 'Game2', url: 'httpgame2')
    expect(game2).not_to be_valid
    expect(game2.errors[:url]).to include('must be a valid URL')
  end

  it 'is not valid with duplicated title' do
    described_class.create(game_title: 'Game1', url: 'https://game1.com')
    game2 = described_class.new(game_title: 'Game1')
    expect(game2).not_to be_valid
    expect(game2.errors[:game_title]).to include('already existed')
  end
end
