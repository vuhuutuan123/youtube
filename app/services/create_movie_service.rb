class CreateMovieService
  attr_accessor :params, :movie, :youtube_video_id

  REGEX_YOUTUBE_URL = %r{^.*(?:(youtu.be/)|(v/)|(/u/\w/)|(embed/)|(watch\?))\??v?=?([^#&?]*).*}

  def initialize(params, movie)
    @params = params
    @movie = movie
  end

  def perform
    movie.youtube_url = params.dig(:movie, :youtube_url)
    raise 'Invalid Youtube Url' unless movie.youtube_url.match?(REGEX_YOUTUBE_URL)

    @youtube_video_id = movie.youtube_url.match(REGEX_YOUTUBE_URL)[6]
    movie.assign_attributes standardize_params
    movie.save!

    {
      success: true
    }
  rescue StandardError => e
    {
      success: false,
      message: e.message
    }
  end

  private

  def standardize_params
    youtube_response = get_detail_youtube_video
    {
      youtube_id: youtube_response['items'][0]['id'],
      title: youtube_response['items'][0]['snippet']['title'],
      description: youtube_response['items'][0]['snippet']['description'],
      image_url: youtube_response['items'][0]['snippet']['thumbnails']['medium']['url']
    }
  end

  def get_detail_youtube_video
    url = URI("https://www.googleapis.com/youtube/v3/videos?part=id%2C+snippet&id=#{youtube_video_id}&key=#{ENV['YOUTUBE_API_KEY']}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    response = https.request(request)

    raise response['error']['message']  if response.code.to_i == 400

    body_response = JSON.parse(response.read_body)
    raise 'Not found video on youtube.' if body_response['items'].blank?

    body_response
  end
end
