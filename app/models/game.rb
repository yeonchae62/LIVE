require 'uri'

class Game
  include Mongoid::Document
  include Mongoid::Timestamps

  field :game_title, type: String
  field :url, type: String

  validates :game_title, presence: true, uniqueness: { case_sensitive: false, message: "already existed"}
  validates :url, presence: true
  validate :valid_url

  private   # some helper methods below

  def valid_url
    uri = URI.parse(url)
    errors.add(:url, "must be a valid URL") unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    errors.add(:url, "must be a valid URL")
  end
end
