# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable

  enum role: { user: 0, moderator: 1, admin: 2 }
  after_initialize :set_default_role, if: :new_record?

  has_many :saved_games, dependent: :destroy
  has_many :games, through: :saved_games, class_name: 'SavedGame'

  def set_default_role
    self.role ||= :user
  end

  def saved_games
    SavedGame.where(user_id: id)
  end
end
