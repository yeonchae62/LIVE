# frozen_string_literal: true

class AddGameTitleAndUrlToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :game_title, :string
    add_column :games, :url, :string
  end
end
