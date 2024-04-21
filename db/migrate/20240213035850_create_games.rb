# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[7.1]
  def change # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    create_table :games do |g| # rubocop:disable Metrics/BlockLength
      g.string 'game_title', null: false
      g.string 'url'
      g.string 'source'
      g.string 'researcher'
      g.string 'included'
      g.string 'exclusion_notes'
      g.string 'publication_year'
      g.string 'developers'
      g.string 'publisher'
      g.string 'used_in_class'
      g.string 'downloadable'
      g.string 'discontinued'
      g.string 'generalized_subject'
      g.string 'subject1'
      g.string 'subject2'
      g.string 'remainder'
      g.string 'teaching'
      g.string 'college_users'
      g.string 'cost'
      g.float 'cost_value'
      g.string 'game_type'
      g.string 'genre'
      g.string 'tags'
      g.string 'game_time'
      g.string 'dimensions'
      g.string 'sound'
      g.string 'platform'
      g.string 'spanish'
      g.string 'other_languages'
      g.string 'notes'
      g.timestamps
    end
  end
end
