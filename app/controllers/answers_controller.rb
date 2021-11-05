class AnswersController < ApplicationController
  def index
    # @answers = Answer.joins(:post).where(post: {user_id: current_user.id}).order(created_at: :desc)
    # @posts = Post.where(user_id: current_user.id).order(created_at: :desc)
    # @answers = Answer.joins(:post).where(user_id: current_user.id).order(created_at: :desc)
    # @posts = Post.joins(:answers).where(answers: { user_id: current_user.id })
    @rooms = Room.joins(:post).where(post: { user_id: current_user.id })
      # .or(Room.joins(:answers).where(answers: { user_id: current_user.id }))
  end

  def show
    @answer = Answer.find(params[:id])
    @post = Post.find(@answer.post_id)
    @answers = Answer.where(post_id: @post.id, room_id: @answer.room_id)
    @answer.read = true
    @answer.save
  end

  def new
    @room = Room.create(post_id: params[:post_id], host_user_id: params[:host_user_id], answerer_user_id: params[:answerer_user_id])
    @answer = @room.build.answer(user_id: current_user.id, post_id: @room.post_id)
    @post = Post.find(params[:post_id])
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.first_answer?(post_id: @answer.post_id, user_id: @answer.user_id, room_id: @answer.room_id)
      @answer.room_id = @answer.user_id
    else
      @answer.room_id = @answer.room_id
    end
    @post = Post.find(params[:answer][:post_id])

    if @answer.save
      respond_to do |format|
        format.html { redirect_to answer_url(@answer), notice: "Message was successfully sent." }
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
