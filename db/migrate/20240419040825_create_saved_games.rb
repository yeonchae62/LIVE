# frozen_string_literal: true

class CreateSavedGames < ActiveRecord::Migration[7.1]
  def change
    create_table :saved_games do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
