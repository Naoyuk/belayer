class RoomsController < ApplicationController
  def index
    @posts = Post.joins(:rooms).where(rooms: {host_user_id: current_user.id}).or(Post.joins(:rooms).where(rooms: {answerer_user_id: current_user.id})).distinct
    @rooms = Room.where(host_user_id: current_user.id).or(Room.where(answerer_user_id: current_user.id))
  end

  def show
    @room = Room.find(params[:id])

    # Make read all unread messages.
    @room.answers.each do |answer|
      if answer.read == false && answer.user_id != current_user.id
        answer.read = true
        answer.save
      end
    end
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
