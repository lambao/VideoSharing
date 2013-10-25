class Api::V1::VideosController  < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  def show
    @video = Video.select(:id, :title, :length, :youtube_id, :user_id, :youtube_url, :description).find(params[:id])
    respond_to do |format|
      format.json { render json: @video }
    end
  end
  def hot_videos
    @hotVideos = Video.select(:id, :title, :length, :youtube_id, :user_id, :youtube_url, :description).order("view_count DESC").limit(10)
    respond_to do |format|
      format.json { render json: @hotVideos }
    end
  end
  def lastest_videos
    @lastestVideo = Video.select(:id, :title, :length, :youtube_id, :user_id, :youtube_url, :description).order("created_at DESC").limit(10)
    respond_to do |format|
      format.json { render json: @lastestVideo }
    end
  end
end