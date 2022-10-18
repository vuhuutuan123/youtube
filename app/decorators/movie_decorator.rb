module MovieDecorator
  def embed_url
    "https://www.youtube.com/embed/#{youtube_id}"
  end

  def youtube_full_url
    "https://youtu.be/#{youtube_id}"
  end
end
