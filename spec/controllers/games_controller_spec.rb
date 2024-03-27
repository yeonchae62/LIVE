# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GamesController do
  let!(:game) { Game.create!(game_title: 'Game1', url: 'http://game1.com') }

  describe 'GET #index' do
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
    context 'with valid attributes' do
      it "creates a new game and redirects to the game's page" do
        expect do
          post :create, params: { game: { game_title: 'New Game', url: 'http://newgame.com' } }
        end.to change(Game, :count).by(1)
        expect(response).to redirect_to(game_path(assigns(:game)))
        expect(flash[:notice]).to eq('Game was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new game and re-renders the new method' do
        expect do
          post :create, params: { game: { game_title: '', url: '' } }
        end.not_to change(Game, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid attributes' do
      it 'updates the requested game and redirects to the game' do
        patch :update, params: { id: game.id, game: { game_title: 'Updated Game Title', url: 'http://updatedgame.com' } }
        game.reload
        expect(game.game_title).to eq('Updated Game Title')
        expect(game.url).to eq('http://updatedgame.com')
        expect(response).to redirect_to(game)
        expect(flash[:notice]).to eq('Game was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the game and re-renders the edit template' do
        patch :update, params: { id: game.id, game: { game_title: '', url: 'invalidurl' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested game and redirects to the games list' do
      expect do
        delete :destroy, params: { id: game.id }
      end.to change(Game, :count).by(-1)
      expect(response).to redirect_to(games_url)
      expect(flash[:notice]).to eq('Game was successfully destroyed.')
    end
  end
end
