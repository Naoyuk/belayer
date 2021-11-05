class RoomsController < ApplicationController
  def index
  end

  def show
    @room = Room.find(params[:id])
  end

  def create
    room = Room.new(room_params)
    if room.save
      respond_to do |format|
        format.html { redirect_to :show, notice: "Message was successfully sent." }
        format.json { render :show, status: :create, location: room }
      end
    else
      respond_to do |format|
        format.html { render :show }
        format.json { render json: room.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def room_params
      params.require(:room).permit(:host_user_id, :answerer_user_id, :post_id)
    end
end
