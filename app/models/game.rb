# frozen_string_literal: true

class Game < ApplicationRecord
  # Validations
  validates :game_title, presence: true, uniqueness: { case_sensitive: false, message: 'already existed' }
  # validates :url, presence: true,
  #           format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: 'must be a valid URL' }

  # Scope for search term matching
  scope :search_by_term, lambda { |search_term|
    where("LOWER(game_title) LIKE :term OR
           LOWER(source) LIKE :term OR
           LOWER(dimensions) LIKE :term OR
           LOWER(publication_year) LIKE :term OR
           LOWER(generalized_subject) LIKE :term OR
           LOWER(subject1) LIKE :term OR
           LOWER(subject2) LIKE :term", term: search_term)
  }

  # Scope for ordering by relevance
  scope :order_relevance, lambda { |search_term|
    select("games.*, CASE
            WHEN LOWER(game_title) LIKE '#{search_term}' THEN 64
            WHEN LOWER(source) LIKE '#{search_term}' THEN 32
            WHEN LOWER(dimensions) LIKE '#{search_term}' THEN 16
            WHEN LOWER(publication_year) LIKE '#{search_term}' THEN 8
            WHEN LOWER(generalized_subject) LIKE '#{search_term}' THEN 4
            WHEN LOWER(subject1) LIKE '#{search_term}' THEN 2
            WHEN LOWER(subject2) LIKE '#{search_term}' THEN 1
            ELSE 0 END AS relevance")
      .order('relevance DESC')
  }
end
