# frozen_string_literal: true

module Filterable
  extend ActiveSupport::Concern

  included do
    helper_method :filter_games
  end

  def filter_games(games, params)
    filters = {
      'price_range' => method(:filter_by_price),
      'platform' => method(:filter_by_platform),
      'subject' => method(:filter_by_subject),
      'genre' => method(:filter_by_genre),
      'dimensions' => method(:filter_by_dimension),
      'other_features' => method(:filter_by_others)
    }

    filters.each do |prefix, filter_method|
      games = filter_method.call(games, params) if params.keys.any? { |key| key.start_with?(prefix) }
    end

    games
  end

  private

  def filter_by_price(games, params)
    price_conditions = []

    price_conditions << 'cost_value BETWEEN 0.0001 AND 10' if params[:price_range_0to10] == 'true'
    price_conditions << 'cost_value BETWEEN 10 AND 20' if params[:price_range_10to20] == 'true'
    price_conditions << 'cost_value BETWEEN 20 AND 9999' if params[:price_range_above20] == 'true'
    price_conditions << 'cost_value = 0.0' if params[:price_range_free] == 'true'

    query = price_conditions.join(' OR ')
    games.where(query)
  end

  def filter_by_platform(games, params)
    platform_params = {
      platform_windows: 'windows',
      platform_mac: 'mac',
      platform_steam: 'steam',
      platform_web: 'web',
      platform_pc: 'pc',
      platform_mobile: %w[ios android],
      platform_html5: 'html5',
      platform_vr: 'vr'
    }
    platforms = platform_params.each_with_object([]) do |(param_key, platform_value), result|
      result.concat(Array(platform_value)) if params[param_key] == 'true'
    end

    query = platforms.map { |platform| "LOWER(platform) LIKE '%#{platform}%'" }.join(' OR ')
    games.where(query)
  end

  def filter_by_subject(games, params)
    subject_params = {
      subject_art: 'art',
      subject_biology: 'biology',
      subject_ecology: 'ecology',
      subject_medical: 'medical',
      subject_nursing: 'nursing',
      subject_math: 'math',
      subject_language: 'language',
      subject_geography: 'geography'
    }
    subjects = subject_params.each_with_object([]) do |(param_key, subject_value), result|
      result << subject_value if params[param_key] == 'true'
    end
    query_parts = subjects.map do
      'LOWER(subject1) LIKE ? OR LOWER(subject2) LIKE ? OR LOWER(remainder) LIKE ?'
    end
    query = query_parts.join(' OR ')

    # Prepare arguments for each part of the query: each subject needs to be repeated for each field
    query_arguments = subjects.flat_map { |subject| %W[%#{subject}% %#{subject}% %#{subject}%] }

    games.where(query, *query_arguments)
  end

  def filter_by_genre(games, params)
    genres = []
    genres << 'single' if params[:genre_single] == 'true'
    genres << 'multi' if params[:genre_multi] == 'true'
    query = genres.map { |genre| "LOWER(genre) LIKE '%#{genre}%'" }.join(' OR ')
    games.where(query)
  end

  def filter_by_dimension(games, params)
    dimensions = []
    dimensions << '2d' if params[:dimensions_2D] == 'true'
    dimensions << '3d' if params[:dimensions_3D] == 'true'
    query = dimensions.map { |dim| "LOWER(dimensions) LIKE '%#{dim}%'" }.join(' OR ')
    games.where(query)
  end

  def filter_by_others(games, params)
    games = games.where(used_in_class: 'Y') if params[:other_features_uic] == 'true'

    games = games.where(downloadable: 'Y') if params[:other_features_downloadable] == 'true'

    games
  end
end
