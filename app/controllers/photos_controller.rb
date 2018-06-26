class PotosController < ApplicationController

  def create
    @room = Room.find(params[:room_id])

    if params[:images]
      params[:image].each do |img|
        @room.photos.create(image: img)
      end

      @photos = @room.photos
      redirect_back(fallback_location: request.referrer, notice: "Saved...")
    end

  end
end
