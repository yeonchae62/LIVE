class SavedGamesController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @game = Game.find(params[:game_id])
      @saved_game = current_user.saved_games.build(game: @game)
  
      if @saved_game.save
        redirect_to games_path, notice: 'Game saved successfully!'
      else
        redirect_to games_path, alert: 'Failed to save the game.'
      end
    end
  end