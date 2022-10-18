class MoviesController < ApplicationController
  before_action :require_user_logged_in!, only: [:new, :create]

  def index
    @movies = if params[:movie_id]
                Movie.where('id < ?', params[:movie_id])
              else
                Movie.all
              end.limit(3).order(id: :desc).includes(:user)
  end

  def new
    @movie = current_user.movies.new
  end

  def create
    @movie = current_user.movies.new
    result = CreateMovieService.new(params, @movie).perform
    if result[:success]
      flash[:success] = 'Your movie was added.'
      redirect_to root_path
    else
      flash.now[:danger] = result[:message]
      render :new
    end
  end
end
