require 'rails_helper'

RSpec.describe "SavedGames", type: :request do
  describe "GET /index" do
    context "when user is logged in" do
      it "returns a success response" do
        user = User.create!(email: 'test@example.com', password: 'password1234', role: 0)
        sign_in user
        get saved_games_path
      end
    end

    context "when user is not logged in" do
      it "redirects to the sign-in page" do
        get saved_games_path
      end
    end
  end

  describe "POST /create" do
    context "when the game is not already saved" do
      let(:user) { User.create!(email: 'test@example.com', password: 'password1234', role: 0) }
      let!(:game) { Game.create!(game_title: 'Game1', url: 'http://game1.com') }

      it "creates a saved game" do
        sign_in user
        post saved_games_path, params: { game_id: game.id }
        expect(SavedGame.count).to eq(1)
      end

      it "redirects to the games index page" do
        sign_in user
        post saved_games_path, params: { game_id: game.id }
        expect(response).to redirect_to(games_path)
      end

      it "sets a success notice" do
        sign_in user
        post saved_games_path, params: { game_id: game.id }
        expect(flash[:notice]).to eq("Game saved successfully!")
      end
    end

    context "when the game is already saved" do
      let(:user) { User.create!(email: 'test@example.com', password: 'password1234', role: 0) }
      let!(:game) { Game.create!(game_title: 'Game1', url: 'http://game1.com') }
      let!(:saved_game) { SavedGame.create(user: user, game: game) }

      it "does not create a duplicate saved game" do
        sign_in user
        post saved_games_path, params: { game_id: game.id }
        expect(SavedGame.count).to eq(1)
      end

      it "redirects to the games index page" do
        sign_in user
        post saved_games_path, params: { game_id: game.id }
        expect(response).to redirect_to(games_path)
      end

      it "sets a notice indicating the game is already saved" do
        sign_in user
        post saved_games_path, params: { game_id: game.id }
        expect(flash[:notice]).to eq("This game is already saved.")
      end
    end
  end
end
