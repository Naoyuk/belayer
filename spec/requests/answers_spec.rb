require 'rails_helper'

RSpec.describe "Answers", type: :request do
  
  let(:valid_attributes) {
    {
      body: 'test test'
    }
  }

  let(:invalid_attributes) {
    {
      body: nil
    }
  }

  let(:owner) { FactoryBot.create(:user) }
  let(:answerer) { FactoryBot.create(:user) }

  before do
    sign_in owner
    @post = FactoryBot.create(:post, user_id: owner.id)
    @answer = FactoryBot.create(:answer, user_id: answerer.id, post_id: @post.id)
  end

  describe "GET /index" do
    it "returns http success" do
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
    context "with valid parameters" do
      it "creates a new Answer" do
        pending("TODO: Use post method and association at the same time")
        expect {
          post posts_url, params: { answer: valid_attributes }
        }.to change(Answer, :count).by(1)
      end

      it "redirects to the post you answered" do
        pending("TODO: use post method and association at the same time")
        post answers_url, params: { answer: valid_attributes }
        expect(response).to redirect_to(post_url(@post))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Answer" do
        expect {
          post answers_url, params: { answer: invalid_attributes }
        }.to change(Answer, :count).by(0)
      end

      it "returns a successful response (i.e to display the 'new' template)" do
         post answers_url, params: { answer: invalid_attributes }
         expect(response).to be_successful
      end
    end
  end

end
