class HomePagesController < ApplicationController
  def home
    @lastestVideo = Video.order("created_at DESC").limit(12)
  end
end
