# frozen_string_literal: true

module Filterable
  extend ActiveSupport::Concern

  included do
    helper_method :filter_games
  end

  def filter_games(games, params)
    games = filter_by_price(games, params) if params.keys.any? { |key| key.start_with?('price_range') }
    # g.where!('lower(source) LIKE ?', "%#{params[:source].downcase}%") if params[:source].present?
    # g.where!('lower(subject) LIKE ?', "%#{params[:subject].downcase}%") if params[:subject].present?
    games
  end

  private

  def filter_by_price(games, params)
    conditions = []
    conditions << games.where(cost: '$0'..'$10.00') if params[:price_range_0to10] == '0-10'
    conditions << games.where(cost: '$10'..'$20.00') if params[:price_range_10to20] == '10-20'
    if params[:price_range_above20] == 'above20'
      conditions << games.where(cost: '$20'..'$99999')
    end
    conditions << games.where('lower(cost) = ?', 'free') if params[:price_range_free] == 'free'

    combined_games = games.none
    conditions.each do |condition|
      combined_games = combined_games.or(condition)
    end
    return combined_games unless combined_games.nil?

    games.none
  end

end
