# frozen_string_literal: true

class AddImageToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :image, :string
  end
end
