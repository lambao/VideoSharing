class HomePagesController < ApplicationController
  def home
    @lastestVideo = Video.order("created_at DESC").limit(12)
  end
  def lastest
    @lastestVideo = Video.order("created_at DESC").paginate(:page => params[:page], :per_page => 12)
  end
end