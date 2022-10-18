class VotesController < ApplicationController
  before_action :require_user_logged_in!, :find_movie

  def create
    vote = current_user.votes.find_or_initialize_by(movie_id: params[:movie_id])
    vote.assign_attributes(state: params[:vote_state])
    vote.save
  end

  private

  def find_movie
    @movie = Movie.find(params[:movie_id])
  end
end
