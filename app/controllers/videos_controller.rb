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
      render new_video_path
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  def my_video
    @videos = current_user.videos.order("created_at DESC").paginate(:page => params[:page], :per_page => 12)
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update_attributes(video_params)
      flash[:success] = "Update successfull"
      redirect_to my_video_path
    else
      render 'edit'
    end
  end

  def destroy
    Video.find(params[:id]).destroy
    flash[:success] = "Video deleted"
    redirect_to my_video_path
  end

  private
  def video_params
    params.require(:video).permit(:title, :youtube_url, :length)
  end

end