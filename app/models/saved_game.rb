# frozen_string_literal: true

class SavedGame < ApplicationRecord
  belongs_to :user
  belongs_to :game
end
