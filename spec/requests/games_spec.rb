# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Games' do
  describe 'GET /games' do
    it 'returns all games' do
      # Setup
      Game.create!(game_title: 'Game1', url: 'http://game1.com')
      Game.create!(game_title: 'Game2', url: 'http://game2.com')

      # Make request
      get games_path, params: {}, headers: { Accept: 'application/json' }

      # Assert response
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.size).to eq(2)
    end
  end

  describe 'POST /games' do
    it 'creates a new game' do
      # Setup
      game_params = { game: { game_title: 'New Game', url: 'http://newgame.com' } }

      # Make request
      post games_path, params: game_params, headers: { Accept: 'application/json' }

      # Assert response
      expect(response).to have_http_status(:created)
      expect(Game.last.game_title).to eq('New Game')
      expect(Game.last.url).to eq('http://newgame.com')
    end
  end

  describe 'PATCH /games/:id' do
    let!(:game) { Game.create!(game_title: 'Original Game', url: 'http://originalgame.com') }

    it 'updates the specified game' do
      user = User.create!(email: 'test2@example.com', password: 'password1234', role: 2)
      sign_in user
      updated_params = { game: { game_title: 'Updated Game', url: 'http://updatedgame.com' } }
      patch game_path(game), params: updated_params, headers: { Accept: 'application/json' }

      game.reload

      expect(response).to have_http_status(:ok)
      expect(game.game_title).to eq('Updated Game')
      expect(game.url).to eq('http://updatedgame.com')
    end
  end

  describe 'DELETE /games/:id' do
    let!(:game) { Game.create!(game_title: 'Game to Delete', url: 'http://gametodelete.com') }

    it 'deletes the specified game' do
      expect do
        user = User.create!(email: 'test2@example.com', password: 'password1234', role: 2)
        sign_in user
        delete game_path(game), params: {}, headers: { Accept: 'application/json' }
      end.to change(Game, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
