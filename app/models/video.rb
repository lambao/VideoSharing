class Video < ActiveRecord::Base
  require 'open-uri'
  require 'json'
  @@key = 'AIzaSyBMLmtbeRrYIlrNvyx-jKeXHmaGOmGmWIY'
  resourcify
  before_save 'parse_youtube'
  belongs_to :user
  validates(:title, presence: true)
  validates(:length, presence: true, numericality: { only_integer: true })
  validates(:youtube_url, presence: true)
  validates(:description, presence: true)
  def get_thump_url(youtube_id)
    url = "https://www.googleapis.com/youtube/v3/videos?id=#{youtube_id}&key=#{@@key}&part=snippet&fields=items(snippet/thumbnails/high/url)"
    tmp =  JSON.parse(open(url).read)
    return tmp['items'][0]['snippet']['thumbnails']['high']['url']
  end

  def get_count_like(url)
    url = URI.parse(URI.encode("https://api.facebook.com/method/fql.query?query=select url,like_count, commentsbox_count from link_stat where url = \"#{url}\""))
    doc = Nokogiri::HTML(open(url))
    doc.xpath('//like_count').each do |like_count|
      return like_count.content
    end
  end

  private
  def parse_youtube
    regex = /^(?:https?:\/\/)?(?:www\.)?\w*\.\w*\/(?:watch\?v=)?((?:p\/)?[\w\-]+)/
    self.youtube_id = self.youtube_url.match(regex)[1]
  end
end

