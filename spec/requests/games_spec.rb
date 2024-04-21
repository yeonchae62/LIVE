# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Games' do
  describe 'GET #index' do
    let!(:games) do
      Game.destroy_all
      game_attributes = [
        { game_title: 'Game1', platform: 'Web', cost_value: 0, genre: 'single', subject1: 'art, biology',
          dimensions: '2D, 3D' },
        { game_title: 'Game2', platform: 'PC', cost_value: 21, genre: 'single', subject2: 'biology',
          dimensions: '2D' },
        { game_title: 'Game3', platform: 'Steam', cost_value: 23, genre: 'multi-player', remainder: 'ecology',
          dimensions: '3D' },
        { game_title: 'Game4', platform: 'Mac', cost_value: 13, genre: 'multi-player', subject1: 'medical',
          used_in_class: 'Y', downloadable: 'Y' },
        { game_title: 'Game5', platform: 'Windows', cost_value: 11, genre: 'single', subject1: 'nursing',
          used_in_class: 'Y' },
        { game_title: 'Game6', platform: 'IOS', cost_value: 6, genre: 'single', subject1: 'math',
          downloadable: 'Y' },
        { game_title: 'Game7', platform: 'HTML5', cost_value: 5, genre: 'single', subject1: 'language' },
        { game_title: 'Game8', platform: 'VR', cost_value: 8, genre: 'single', subject1: 'geography' }
      ]
      game_attributes.map do |attrs|
        Game.create!(attrs)
      end
    end

    context 'when no filters are applied' do
      before do
        get games_path
      end

      it 'displays all games' do
        expect(assigns(:games)).to match_array(games)
      end

      it 'renders index template' do
        expect(response).to render_template(:index)
      end

      it 'responds with status:ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when price range filter is applied' do
      it 'displays free games' do
        get games_path, params: { price_range_free: 'true' }
        expect(assigns(:games)).to contain_exactly(games[0])
      end

      it 'displays games under $10' do
        get games_path, params: { price_range_free: 'true', price_range_0to10: 'true' }
        expect(assigns(:games)).to contain_exactly(games[0], *games[5..7])
      end

      it 'displays games under $20' do
        get games_path, params: { price_range_free: 'true', price_range_0to10: 'true', price_range_10to20: 'true' }
        expect(assigns(:games)).to contain_exactly(games[0], *games[3..7])
      end

      it 'displays games above $20' do
        get games_path, params: { price_range_above20: 'true' }
        expect(assigns(:games)).to contain_exactly(games[1], games[2])
      end
    end

    context 'when platform filter is applied' do
      it 'displays games available on Web' do
        get games_path, params: { platform_web: 'true' }
        expect(assigns(:games)).to contain_exactly(games[0])
      end

      it 'displays games available on PC' do
        get games_path, params: { platform_pc: 'true' }
        expect(assigns(:games)).to contain_exactly(games[1])
      end

      it 'displays games available on Steam' do
        get games_path, params: { platform_steam: 'true' }
        expect(assigns(:games)).to contain_exactly(games[2])
      end

      it 'displays games available on Mac' do
        get games_path, params: { platform_mac: 'true' }
        expect(assigns(:games)).to contain_exactly(games[3])
      end

      it 'displays games available on Windows' do
        get games_path, params: { platform_windows: 'true' }
        expect(assigns(:games)).to contain_exactly(games[4])
      end

      it 'displays games available on Mobile' do
        get games_path, params: { platform_mobile: 'true' }
        expect(assigns(:games)).to contain_exactly(games[5])
      end

      it 'displays games available on HTML5' do
        get games_path, params: { platform_html5: 'true' }
        expect(assigns(:games)).to contain_exactly(games[6])
      end

      it 'displays games available on VR' do
        get games_path, params: { platform_vr: 'true' }
        expect(assigns(:games)).to contain_exactly(games[7])
      end
    end

    context 'when genre filter is applied' do
      it 'displays games for single player' do
        get games_path, params: { genre_single: 'true' }
        expect(assigns(:games)).to contain_exactly(games[0], games[1], *games[4..7])
      end

      it 'displays games for multiple players' do
        get games_path, params: { genre_multi: 'true' }
        expect(assigns(:games)).to contain_exactly(games[2], games[3])
      end
    end

    context 'when subject filter is applied' do
      it 'display games about Art' do
        get games_path, params: { subject_art: 'true' }
        expect(assigns(:games)).to contain_exactly(games[0])
      end

      it 'display games about Biology' do
        get games_path, params: { subject_biology: 'true' }
        expect(assigns(:games)).to contain_exactly(games[0], games[1])
      end

      it 'display games about Ecology' do
        get games_path, params: { subject_ecology: 'true' }
        expect(assigns(:games)).to contain_exactly(games[2])
      end

      it 'display games about Medical' do
        get games_path, params: { subject_medical: 'true' }
        expect(assigns(:games)).to contain_exactly(games[3])
      end

      it 'display games about Nursing' do
        get games_path, params: { subject_nursing: 'true' }
        expect(assigns(:games)).to contain_exactly(games[4])
      end

      it 'display games about Math' do
        get games_path, params: { subject_math: 'true' }
        expect(assigns(:games)).to contain_exactly(games[5])
      end

      it 'display games about Language' do
        get games_path, params: { subject_language: 'true' }
        expect(assigns(:games)).to contain_exactly(games[6])
      end

      it 'display games about Geography' do
        get games_path, params: { subject_geography: 'true' }
        expect(assigns(:games)).to contain_exactly(games[7])
      end
    end

    context 'when dimensions filter is applied' do
      it 'display 2D games' do
        get games_path, params: { dimensions_2D: 'true' }
        expect(assigns(:games)).to contain_exactly(games[0], games[1])
      end

      it 'display 3D games' do
        get games_path, params: { dimensions_3D: 'true' }
        expect(assigns(:games)).to contain_exactly(games[0], games[2])
      end
    end

    context 'when other filters are applied' do
      it 'display games used in classroom' do
        get games_path, params: { other_features_uic: 'true' }
        expect(assigns(:games)).to contain_exactly(games[3], games[4])
      end

      it 'display games downloadable' do
        get games_path, params: { other_features_downloadable: 'true' }
        expect(assigns(:games)).to contain_exactly(games[3], games[5])
      end

      it 'display games downloadable and used in classroom' do
        get games_path, params: { other_features_uic: 'true', other_features_downloadable: 'true' }
        expect(assigns(:games)).to contain_exactly(games[3])
      end
    end

    context 'when multiple filters are applied' do
      it 'displays games that meet all criteria' do
        get games_path, params: { platform_steam: 'true', price_range_above: 'true' }
        expect(assigns(:games)).to contain_exactly(games[2])
      end
    end
  end

  describe 'POST /games' do
    it 'creates a new game' do
      # Sign in
      user = User.create!(email: 'test2@example.com', password: 'password1234', role: 2)
      sign_in user

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
