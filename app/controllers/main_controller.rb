# frozen_string_literal: true

class MainController < ApplicationController
  before_action :authenticate_user!, only: %i[user_management change_role]
  before_action :check_admin, only: %i[user_management change_role]

  def index
    @most_watched = Game.where(game_title: ['Lost Recipes', 'Roboco', 'Zero Threat',
                                            'Arté: Hemut', 'Variant: Limits', 'Arté: Mercenas'])
  end

  def user_management
    @users = User.all
  end

  def change_role
    user = User.find(params[:user_id])
    user.update(role: params[:role])
    redirect_to user_management_path, notice: 'User role updated successfully.'
  end

  private

  def check_admin
    return if current_user.admin?

    redirect_to root_path, alert: 'You are not authorized to view this page.'
  end
end
