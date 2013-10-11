class VideosController < ApplicationController
  before_filter :authenticate_user!

  def new
    @video = Video.new
  end
  def create
    @video = current_user.videos.build(video_params)
    if @video.save
      flash[:success] = "Video posted!"
      redirect_to root_path
    else
      render 'videos/new'
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  def my_video
    @videos = current_user.videos.paginate(:page => params[:page], :per_page => 10)
  end

  private
  def video_params
    params.require(:video).permit(:title, :youtube_id, :length)
  end

end