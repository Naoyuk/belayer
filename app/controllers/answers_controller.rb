class AnswersController < ApplicationController
  def index
    @answers = Answer.joins(:post).where(post: {user_id: current_user.id}).order(created_at: :desc)
  end

  def show
    @answer = Answer.find(params[:id])
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

  private
    def answer_params
      params.require(:answer).permit(:body, :read, :snoozed_at, :post_id, :user_id)
    end
end
