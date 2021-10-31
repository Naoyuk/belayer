require 'rails_helper'

RSpec.describe "Answers", type: :request do
  
  describe "GET /index" do
    it "returns http success" do
      user = FactoryBot.create(:user)
      sign_in user
      get answers_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    owner = FactoryBot.create(:user)
    answerer = FactoryBot.create(:user)
    it "returns http success" do
      sign_in owner
      @post =  FactoryBot.create(:post, user_id: owner.id)
      @answer = FactoryBot.create(:answer, user_id: answerer.id, post_id: @post.id)
      get answer_url(@answer)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      @owner = FactoryBot.create(:user)
      @answerer = FactoryBot.create(:user)
      sign_in @owner
      @post =  FactoryBot.create(:post, user_id: @owner.id)
      @answer = FactoryBot.create(:answer, user_id: @answerer.id, post_id: @post.id)
      get new_answer_url(post_id: @post.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      it "creates a new Answer" do
        @owner = FactoryBot.create(:user)
        @answerer = FactoryBot.create(:user)
        sign_in @owner
        @post =  FactoryBot.create(:post, user_id: @owner.id)
        valid_attributes = { body: 'Text text,.', post_id: @post.id, user_id: @answerer.id }
        expect {
          post answers_url, params: { answer: valid_attributes }
        }.to change{ Answer.count }.by(1)
      end

      it "redirects to the post you answered" do
        @owner = FactoryBot.create(:user)
        @answerer = FactoryBot.create(:user)
        sign_in @owner
        @post =  FactoryBot.create(:post, user_id: @owner.id)
        valid_attributes = { body: 'Text text,.', post_id: @post.id, user_id: @answerer.id }
        post answers_url, params: { answer: valid_attributes }
        expect(response).to redirect_to(post_url(@post))
      end
    end

    context "with invalid parameters" do

      it "does not create a new Answer" do
        @owner = FactoryBot.create(:user)
        @answerer = FactoryBot.create(:user)
        sign_in @owner
        @post =  FactoryBot.create(:post, user_id: @owner.id)
        @answer = FactoryBot.create(:answer, user_id: @answerer.id, post_id: @post.id)
        invalid_attributes = { body: nil, post_id: @post.id, user_id: @answerer.id }
        expect {
          post answers_url, params: { answer: invalid_attributes }
        }.to change(Answer, :count).by(0)
      end

      it "returns a successful response (i.e to display the 'new' template)" do
        @owner = FactoryBot.create(:user)
        @answerer = FactoryBot.create(:user)
        sign_in @owner
        @post =  FactoryBot.create(:post, user_id: @owner.id)
        @answer = FactoryBot.create(:answer, user_id: @answerer.id, post_id: @post.id)
        invalid_attributes = { body: nil, post_id: @post.id, user_id: @answerer.id }
        post answers_url, params: { answer: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

end
