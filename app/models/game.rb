# frozen_string_literal: true

class Game < ApplicationRecord
  # Validations
  validates :game_title, presence: true, uniqueness: { case_sensitive: false, message: 'already existed' }
  # validates :url, presence: true,
  #           format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: 'must be a valid URL' }
end
