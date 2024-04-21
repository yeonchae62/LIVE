# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GamesController do
  Game.delete_all

  describe 'GET #index' do
    let!(:game) { Game.create!(game_title: 'Game1', url: 'http://game1.com') }

    context 'without search parameters' do
      it 'assigns all games as @games and renders the index template' do
        get :index
        expect(assigns(:games)).to eq([game])
        expect(response).to render_template('index')
      end
    end

    context 'with search parameters' do
      let!(:matching_game) do
        Game.create!(game_title: 'Special Search Term', source: 'Another Source',
                     publication_year: '2022', subject1: 'Subject1', subject2: 'Subject2')
      end

      it 'assigns matching games as @games' do
        get :index, params: { search: 'special search' }
        expect(assigns(:games)).to contain_exactly(matching_game)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes with signed in user' do
      it "creates a new game and redirects to the game's page" do
        user = User.create!(email: 'test2@example.com', password: 'password1234', role: 2)
        sign_in user
        expect do
          post :create, params: { game: { game_title: 'New Game', url: 'http://newgame.com' } }
        end.to change(Game, :count).by(1)
        expect(response).to redirect_to(game_path(assigns(:game)))
        expect(flash[:notice]).to eq('Game was successfully created.')
      end
    end

    context 'with valid attributes with unsigned in user' do
      it 'returns forbidden' do
        post :create, params: { game: { game_title: 'New Game', url: 'http://newgame.com' } }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new game and re-renders the new method' do
        expect do
          user = User.create!(email: 'test2@example.com', password: 'password1234', role: 2)
          sign_in user
          post :create, params: { game: { game_title: '', url: '' } }
        end.not_to change(Game, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#edit' do
    let!(:game) { Game.create!(game_title: 'Game1', url: 'http://game1.com') }

    context 'with not signed in' do
      it 'return forbidden' do
        get :edit, params: { id: game.id }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    let!(:game) { Game.create!(game_title: 'Game1', url: 'http://game1.com') }

    context 'with valid attributes - signed in' do
      it 'updates the requested game and redirects to the game' do
        user = User.create!(email: 'test2@example.com', password: 'password1234', role: 2)
        sign_in user
        patch :update, params: { id: game.id, game: { game_title: 'Updated Game Title', url: 'http://updatedgame.com' } }
        game.reload
        expect(game.game_title).to eq('Updated Game Title')
        expect(game.url).to eq('http://updatedgame.com')
        expect(response).to redirect_to(game)
        expect(flash[:notice]).to eq('Game was successfully updated.')
      end
    end

    context 'with valid attributes - not signed in' do
      it 'updates the requested game and redirects to the game' do
        patch :update, params: { id: game.id, game: { game_title: 'Updated Game Title', url: 'http://updatedgame.com' } }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the game and re-renders the edit template' do
        user = User.create!(email: 'test2@example.com', password: 'password1234', role: 2)
        sign_in user
        patch :update, params: { id: game.id, game: { game_title: '', url: 'invalidurl' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:game) { Game.create!(game_title: 'Game1', url: 'http://game1.com') }

    it 'destroys the requested game and redirects to the games list' do
      user = User.create!(email: 'test2@example.com', password: 'password1234', role: 2)
      sign_in user
      expect do
        delete :destroy, params: { id: game.id }
      end.to change(Game, :count).by(-1)
      expect(response).to redirect_to(games_url)
      expect(flash[:notice]).to eq('Game was successfully destroyed.')
    end
  end

  describe 'DELETE #destroy - not signed in' do
    let!(:game) { Game.create!(game_title: 'Game1', url: 'http://game1.com') }

    it 'destroys the requested game and redirects to the games list' do
      delete :destroy, params: { id: game.id }
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe '#sort_games' do
    before do
      Game.create!(game_title: 'Art', publication_year: 2000, cost_value: 50)
      Game.create!(game_title: 'Boy', publication_year: 2005, cost_value: 30, subject2: 'match')
      Game.create!(game_title: 'Cat', publication_year: 2010, cost_value: 20, subject1: 'match')
      Game.create!(game_title: 'Dog', publication_year: 2015, cost_value: 40)
    end

    it 'sorts games by title in ascending order' do
      get :index, params: { sort_by: 'Title' }
      expect(assigns(:games).map(&:game_title)).to eq(%w[Art Boy Cat Dog])
    end

    it 'sorts games by publication year in descending order' do
      get :index, params: { sort_by: 'Publication Year' }
      expect(assigns(:games).map(&:publication_year)).to eq(%w[2015 2010 2005 2000])
    end

    it 'sorts games by highest cost first' do
      get :index, params: { sort_by: 'Highest Price' }
      expect(assigns(:games).map(&:cost_value)).to eq([50, 40, 30, 20])
    end

    it 'sorts games by lowest cost first' do
      get :index, params: { sort_by: 'Lowest Price' }
      expect(assigns(:games).map(&:cost_value)).to eq([20, 30, 40, 50])
    end

    it 'sorts games by relevance' do
      Game.create!(game_title: 'match', publication_year: 2015, cost: 40)
      get :index, params: { search: 'match', sort_by: 'Relevance' }
      expect(assigns(:games).map(&:game_title)).to eq(%w[match Cat Boy])
    end
  end
end
