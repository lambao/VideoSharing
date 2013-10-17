class Api::V1::VideosController  < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  def show
    @video = Video.find(params[:id])
    respond_to do |format|
      format.json { render json: @video }
    end
  end
  def hot_videos
    @hotVideos = Video.order("view_count DESC")
    respond_to do |format|
      format.json { render json: @hotVideos }
    end
  end
  def lastest_videos
    @lastestVideo = Video.order("created_at DESC")
    respond_to do |format|
      format.json { render json: @lastestVideo }
    end
  end
end