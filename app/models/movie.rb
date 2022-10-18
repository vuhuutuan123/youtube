class Movie < ApplicationRecord
  include MovieDecorator

  attr_accessor :youtube_url

  belongs_to :user
  has_many :votes

  validates_presence_of :youtube_id, :title
  validates_length_of :youtube_id, is: 11
end
