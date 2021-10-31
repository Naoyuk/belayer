require 'rails_helper'

RSpec.describe "Answers", type: :request do
  
  before do
    @user = FactoryBot.create(:user)
    @owner = FactoryBot.create(:user)
    @answerer = FactoryBot.create(:user)
    sign_in @owner
    @post =  FactoryBot.create(:post, user: @owner)
    @answer = FactoryBot.create(:answer, user: @answerer, post: @post)
  end

  describe "GET /index" do
    it "returns http success" do
      sign_in @user
      get answers_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get answer_url(@answer)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get new_answer_url(post_id: @post.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "is valid to answer to other's post" do
      answer = FactoryBot.build(:answer, user: @answerer, post: @post)
      expect(answer).to be_valid
    end

    it "is invalid to answer to your own post" do
      pending("TODO: Implement in Model")
      answer = FactoryBot.build(:answer, user: @owner, post: @post)
      expect(answer).to_not be_valid
    end

    context "with valid parameters" do
      before do
        @valid_attributes = { body: 'Text text,.', post_id: @post.id, user_id: @answerer.id }
      end

      it "creates a new Answer" do
        expect {
          post answers_url, params: { answer: @valid_attributes }
        }.to change{ Answer.count }.by(1)
      end

      it "redirects to the post you answered" do
        post answers_url, params: { answer: @valid_attributes }
        expect(response).to redirect_to(post_url(@post))
      end
    end

    context "with invalid parameters" do
      before do
        @invalid_attributes = { body: nil, post_id: @post.id, user_id: @answerer.id }
      end

      it "does not create a new Answer" do
        expect {
          post answers_url, params: { answer: @invalid_attributes }
        }.to change(Answer, :count).by(0)
      end

      it "returns a successful response (i.e to display the 'new' template)" do
        post answers_url, params: { answer: @invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

end
