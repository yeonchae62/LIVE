# frozen_string_literal: true

class SavedGamesController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def create
    @game = Game.find(params[:game_id])
    create_saved_game
  end

  private

  def create_saved_game
    if current_user.saved_games.exists?(game_id: @game.id)
      redirect_to request.referer, notice: 'This game is already saved.'
    else
      save_game
    end
  end

  def save_game
    @saved_game = current_user.saved_games.build(game: @game)

    return unless @saved_game.save

    redirect_to request.referer, notice: 'Game saved successfully!'
  end
end
