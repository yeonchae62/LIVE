# frozen_string_literal: true

class SavedGamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @saved_games = current_user.saved_games
  end

  def create
    @game = Game.find(params[:game_id])

    # Check if the game is already saved by the current user
    if current_user.saved_games.exists?(game_id: @game.id)
      redirect_to games_path, notice: 'This game is already saved.'
    else
      @saved_game = current_user.saved_games.build(game: @game)

      if @saved_game.save
        redirect_to games_path, notice: 'Game saved successfully!'
      else
        redirect_to games_path, alert: 'Failed to save the game.'
      end
    end
  end
end
