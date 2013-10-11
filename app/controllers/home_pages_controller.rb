class HomePagesController < ApplicationController
  def home
    @lastestVideo = Video.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
  end
end
