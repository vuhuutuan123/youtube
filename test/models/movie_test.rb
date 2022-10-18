require "test_helper"

class MovieTest < ActiveSupport::TestCase
  test 'validation youtube_id' do
    movie1 = FactoryBot.build(:movie, youtube_id: '')
    assert_equal movie1.valid?, false
    assert_includes movie1.errors.messages[:youtube_id], "can't be blank"

    movie2 = FactoryBot.build(:movie, youtube_id: '1')
    assert_equal movie2.valid?, false
    assert_includes movie2.errors.messages[:youtube_id], "is the wrong length (should be 11 characters)"
  end

  test 'validation title' do
    movie = FactoryBot.build(:movie, youtube_id: '1', title: '')
    assert_equal movie.valid?, false
    assert_includes movie.errors.messages[:title], "can't be blank"
  end
end
