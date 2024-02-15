require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  before do
    @game = Game.create!(game_title: "Game1", url: "http://game1.com")
  end

  describe "GET #index" do
    it "assigns @games and renders the index template" do
      get :index
      expect(assigns(:games)).to eq([@game])
      expect(response).to render_template("index")
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new game and redirects to the game's page" do
        expect {
          post :create, params: { game: { game_title: "New Game", url: "http://newgame.com" } }
        }.to change(Game, :count).by(1)
        expect(response).to redirect_to(game_path(assigns(:game)))
        expect(flash[:notice]).to eq("Game was successfully created.")
      end
    end

    context "with invalid attributes" do
      it "does not create a new game and re-renders the new method" do
        expect {
          post :create, params: { game: { game_title: "", url: "" } }
        }.to_not change(Game, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH/PUT #update" do
    context "with valid attributes" do
      it "updates the requested game and redirects to the game" do
        patch :update, params: { id: @game.id, game: { game_title: "Updated Game Title", url: "http://updatedgame.com" } }
        @game.reload
        expect(@game.game_title).to eq("Updated Game Title")
        expect(@game.url).to eq("http://updatedgame.com")
        expect(response).to redirect_to(@game)
        expect(flash[:notice]).to eq("Game was successfully updated.")
      end
    end

    context "with invalid attributes" do
      it "does not update the game and re-renders the edit template" do
        patch :update, params: { id: @game.id, game: { game_title: "", url: "invalidurl" } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested game and redirects to the games list" do
      expect {
        delete :destroy, params: { id: @game.id }
      }.to change(Game, :count).by(-1)
      expect(response).to redirect_to(games_url)
      expect(flash[:notice]).to eq("Game was successfully destroyed.")
    end
  end
end
