class User < ApplicationRecord
  has_secure_password

  has_many :movies
  has_many :votes
  has_many :voting_movies, through: :votes, source: :movie

  validates :email, presence: true, uniqueness: true, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  }

  def state_voting_movie(movie)
    votes.find_by(movie: movie)&.state
  end
end
