class AnswersController < ApplicationController
  def index
    @answers = Answer.joins(:post).where(post: {user_id: current_user.id}).order(created_at: :desc)
  end

  def show
    @answer = Answer.find(params[:id])
    @answer.read = true
    @answer.save
  end

  def new
    @answer = Answer.new
    @post = Post.find(params[:post_id])
  end

  def create
    @answer = Answer.new(answer_params)
    @post = Post.find(params[:answer][:post_id])

    if @answer.save
      respond_to do |format|
        format.html { redirect_to post_url(@answer.post_id), notice: "Message was successfully sent." }
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
      params.require(:answer).permit(:body, :read, :snoozed_at, :post_id, :user_id)
    end
end
