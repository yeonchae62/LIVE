# frozen_string_literal: true

class GamesController < ApplicationController
  include Filterable
  before_action :set_game, only: %i[show edit update destroy]

  # GET /games or /games.json
  def index
    @games = load_games
    @games = filter_games(@games, params)
    respond_to do |format|
      format.html
      format.js
    end
    @games = @games.paginate(page: params[:page], per_page: 8) unless @games.nil?

    # Remember the sorting option in session or params to persist state after refresh
    @sort_by = params[:sort_by] || 'Relevance'
  end

  # GET /games/1 or /games/1.json
  def show; end

  # GET /games/new
  def new
    unless user_signed_in? && current_user.admin?
      show_forbidden
      return
    end
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
    show_forbidden if !user_signed_in? || current_user.user?
  end

  # POST /games or /games.json
  def create
    unless user_signed_in? && current_user.admin?
      show_forbidden
      return
    end
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to game_url(@game), notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    if !user_signed_in? || current_user.user?
      show_forbidden
    else
      update_impl
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    if !user_signed_in? || !current_user.admin?
      show_forbidden
    else
      destroy_impl
    end
  end

  # def current_user
  #   puts "session"
  #   puts session[:email]
  #   @current_user ||= User.find(session[:email])
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  GAME_PARAMS = %i[
    game_title url source researcher included exclusion_notes
    publication_year developers publisher used_in_class downloadable
    discontinued generalized_subject subject1 subject2 remainder
    teaching college_users cost game_type genre tags game_time
    dimensions sound platform spanish other_languages notes
  ].freeze

  def game_params
    params.require(:game).permit(GAME_PARAMS)
  end

  def search_games(term)
    search_term = "%#{term.downcase}%"
    Game.search_by_term(search_term)
  end

  def sort_games(games, sort_by, search_term)
    case sort_by
    when 'Title'
      games.order('LOWER(game_title) ASC')
    when 'Publication Year'
      games.order('publication_year DESC')
    when 'Lowest Price'
      games.order('cost_value ASC')
    when 'Highest Price'
      games.order('cost_value DESC')
    when 'Relevance'
      games.order_relevance("%#{search_term.downcase}%")
    else
      games
    end
  end

  def load_games
    @games = Game.all
    @games = search_games(params[:search]) if params[:search].present?
    @games = sort_games(@games, params[:sort_by], params[:search])
  end

  def show_forbidden
    respond_to do |format|
      format.html { render :forbidden, status: :forbidden }
    end
  end

  def update_impl
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to game_url(@game), notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_impl
    @game.destroy!
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
