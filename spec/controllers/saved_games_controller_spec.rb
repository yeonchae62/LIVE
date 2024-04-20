require 'rails_helper'

RSpec.describe SavedGamesController, type: :controller do
    describe "POST #create" do
      context "when user is authenticated" do
        before do
          @user = User.create(email: "test@example.com", password: "password")
          sign_in @user
        end
  
        context "with valid params" do
          let(:game) { Game.create(game_title: "Test Game") }
  
          it "creates a new saved game" do
            expect {
              post :create, params: { game_id: game.id }
            }.to change(@user.saved_games, :count).by(1)
          end
  
          it "redirects to games path with success notice" do
            post :create, params: { game_id: game.id }
            expect(response).to redirect_to(games_path)
            expect(flash[:notice]).to eq('Game saved successfully!')
          end
        end
  
        context "when the game is already saved by the user" do
          let(:game) { Game.create(game_title: "Test Game") }
  
          before do
            @user.saved_games.create(game: game)
          end
  
          it "does not create a new saved game" do
            expect {
              post :create, params: { game_id: game.id }
            }.to_not change(@user.saved_games, :count)
          end
  
          it "redirects to games path with notice" do
            post :create, params: { game_id: game.id }
            expect(response).to redirect_to(games_path)
            expect(flash[:notice]).to eq('This game is already saved.')
          end
        end
      end
  
      context "when user is not authenticated" do
        it "redirects to sign in page" do
          post :create
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end
  