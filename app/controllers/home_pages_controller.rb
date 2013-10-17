class HomePagesController < ApplicationController
  def home
    @lastestVideo = Video.order("created_at DESC").limit(8)
    @hotVideo = Video.order("view_count DESC").limit(8)
  end
  def lastest
    @lastestVideo = Video.order("created_at DESC").paginate(:page => params[:page], :per_page => 8)
  end
  def hot
    @hotVideos = Video.order("view_count DESC").paginate(:page => params[:page], :per_page => 8)
  end
end