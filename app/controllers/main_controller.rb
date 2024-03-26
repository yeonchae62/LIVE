# frozen_string_literal: true

class MainController < ApplicationController
  def index
    @most_watched = Game.where(game_title: ['Lost Recipes', 'Roboco', 'Morning in Your Eyes',
                                            'Arté: Hemut', 'Variant: Limits', 'Arté: Mercenas'])
  end
  def user_management
    @users = User.all
  end
end
