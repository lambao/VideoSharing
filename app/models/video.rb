class Video < ActiveRecord::Base
  @@key = 'AIzaSyBMLmtbeRrYIlrNvyx-jKeXHmaGOmGmWIY'

  require 'open-uri'
  require 'json'
  require 'uri'

  resourcify
  attr_accessor :thumb_remote_url
  attr_reader :thumb_remote_url

  has_attached_file :thumb,
                    :command_path => "/usr/local/bin/",
                    :styles => { :featured => "123x87",
                                 :newthumb => "213x143",
                                 :oldthumb => "295x166" },
                    :url => "/assets/thumbs/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/thumbs/:id/:style/:basename.:extension"
  belongs_to :user
  before_save :parse_youtube
  validates(:title, presence: true)
  validates(:length, presence: true, numericality: { only_integer: true })
  validates(:youtube_url, presence: true)
  validates(:description, presence: true)
  validates_attachment_content_type :thumb, :content_type => 'image/jpeg'

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

  def thumb_remote_url=(url_value)
    self.thumb = URI.parse(url_value)
    # Assuming url_value is http://example.com/photos/face.png
    # avatar_file_name == "face.png"
    # avatar_content_type == "image/png"
    @thumb_remote_url = url_value
  end

  private
  def parse_youtube
    regex = /^(?:https?:\/\/)?(?:www\.)?\w*\.\w*\/(?:watch\?v=)?((?:p\/)?[\w\-]+)/
    self.youtube_id = self.youtube_url.match(regex)[1]
    self.thumb_remote_url = get_thump_url(self.youtube_id)
  end
end

