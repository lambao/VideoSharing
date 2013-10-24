class VideosController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :increase_count_view]
  load_and_authorize_resource

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

  def increase_count_view
    @video = Video.find(params[:id])
    @video.increment!('view_count')
  end

  def my_video
    @videos = current_user.videos.order("created_at DESC").paginate(:page => params[:page], :per_page => 12)
  end

  def edit
    @video = Video.find(params[:id])
    if !(current_user.id == @video.user.id)
        flash[:error] = "You cannot edit video of other user"
        redirect_to root_path
    end
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
    params.require(:video).permit(:title, :youtube_url, :description, :length, :thumb)
  end
end