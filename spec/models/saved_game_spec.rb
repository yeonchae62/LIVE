require 'rails_helper'

RSpec.describe SavedGamesController, type: :controller do
  describe "POST #index" do
    context "when user is authenticated" do
      let(:user) { create(:user) }
      let(:game) { create(:game) }

      before { sign_in user }

      context "with valid params" do
        it "creates a new saved game" do
          post :index, params: { game_id: game.id }
          expect(user.saved_games.last.game).to eq(game)
        end

        it "redirects to games path with success notice" do
          post :index, params: { game_id: game.id }
          expect(response).to redirect_to(games_path)
          expect(flash[:notice]).to eq('Game saved successfully!')
        end
      end

      context "when the game is already saved by the user" do
        before { user.saved_games.create(game: game) }

        it "does not create a new saved game" do
          expect {
            post :index, params: { game_id: game.id }
          }.not_to change(SavedGame, :count)
        end

        it "redirects to games path with notice" do
          post :index, params: { game_id: game.id }
          expect(response).to redirect_to(games_path)
          expect(flash[:notice]).to eq('This game is already saved.')
        end
      end
    end

    context "when user is not authenticated" do
      it "redirects to sign in page" do
        post :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
