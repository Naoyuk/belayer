class AnswersController < ApplicationController
  def new
    @room = Room.find_or_create_by(id: params[:room_id]) do |room|
      room.post_id = params[:post_id]
      room.answerer_user_id = params[:answerer_user_id]
      room.host_user_id = params[:host_user_id]
    end
    @answer = @room.answers.new(user_id: current_user.id, post_id: @room.post_id)
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id
    @post = Post.find(params[:answer][:post_id])

    if @answer.save
      respond_to do |format|
        format.html { redirect_to room_url(@answer.room), notice: "Message was successfully sent." }
        format.json { render :show, status: :created, location: @answer.post }
      end
    else
      respond_to do |format|
        format.html { render :new, post_id: @post.id }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @answer = Answer.find(params[:id])
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to answers_url, notice: "Post was successfully updated." }
        format.json { render :index }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def unread
    @answer = Answer.find(params[:id])
    respond_to do |format|
      if @answer.unread
        format.html { redirect_to answers_url }
        #TODO: format.json is not written yet. I'm wondering what should I return.
      else
        format.html { render :show }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def answer_params
      params.require(:answer).permit(:body, :read, :snoozed_at, :post_id, :user_id, :room_id)
    end
end
