# spec/controllers/saved_games_controller_spec.rb
require 'rails_helper'

RSpec.describe SavedGamesController, type: :controller do
  describe "POST #create" do
    context "when the game is not already saved" do
      let(:user) { User.create!(email: 'test@example.com', password: 'password1234', role: 0) }
      let!(:game) { Game.create!(game_title: 'Game1', url: 'http://game1.com') }

      it "creates a saved game" do
        sign_in user
        post :create, params: { game_id: game.id }
        expect(SavedGame.count).to eq(1)
      end

      it "redirects to the games index page" do
        sign_in user
        post :create, params: { game_id: game.id }
        expect(response).to redirect_to(games_path)
      end

      it "sets a success notice" do
        sign_in user
        post :create, params: { game_id: game.id }
        expect(flash[:notice]).to eq("Game saved successfully!")
      end
    end

    context "when the game is already saved" do
      let(:user) { User.create!(email: 'test@example.com', password: 'password1234', role: 0) }
      let!(:game) { Game.create!(game_title: 'Game1', url: 'http://game1.com') }
      let!(:saved_game) { SavedGame.create(user: user, game: game) }

      it "does not create a duplicate saved game" do
        sign_in user
        post :create, params: { game_id: game.id }
        expect(SavedGame.count).to eq(1)
      end

      it "redirects to the games index page" do
        sign_in user
        post :create, params: { game_id: game.id }
        expect(response).to redirect_to(games_path)
      end

      it "sets a notice indicating the game is already saved" do
        sign_in user
        post :create, params: { game_id: game.id }
        expect(flash[:notice]).to eq("This game is already saved.")
      end
    end
  end
end
