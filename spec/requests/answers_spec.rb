require 'rails_helper'

RSpec.describe "Answers", type: :request do
  
  before do
    @user = FactoryBot.create(:user)
    @owner = FactoryBot.create(:user)
    @answerer = FactoryBot.create(:user)
  end

  describe "GET /new" do
    context "as an authenticated user" do
      before do
        sign_in @owner
        @post =  FactoryBot.create(:post, user: @owner)
        @room =  FactoryBot.create(:room, post: @post, host_user_id: @owner.id, answerer_user_id: @answerer.id)
        @answer = FactoryBot.create(:answer, user: @answerer, post: @post, room: @room)
      end

      it "returns http success" do
        get new_answer_url(
          post_id: @post.id, 
          room_id: @room.id, 
          answerer: @room.answerer, 
          host_user_id: @room.host_user_id
        )
        expect(response).to have_http_status(:success)
      end

      it "renders a successful response" do
        get new_answer_url(
          post_id: @post.id, 
          room_id: @room.id, 
          answerer_user_id: @room.answerer_user_id, 
          host_user_id: @room.host_user_id
        )
        expect(response).to have_http_status "200"
      end
    end

    context "as a guest" do
      it "returns a 302 response" do
        get new_answer_url
        expect(response).to have_http_status "302"
      end

      it "redirect to the sign-in page" do
        get new_answer_url
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "POST /create" do
    context "as an authenticated user" do
      before do
        sign_in @owner
        @post =  FactoryBot.create(:post, user: @owner)
        @room =  FactoryBot.create(:room, post: @post, host_user_id: @owner.id, answerer_user_id: @answerer.id)
        @answer = FactoryBot.create(:answer, user: @answerer, post: @post, room: @room)
        @valid_attributes = { body: 'Text text,.', room_id: @room.id, post_id: @post.id, user_id: @answerer.id }
      end

      it "is valid to answer to a post" do
        answer = FactoryBot.build(:answer, user: @answerer, post: @post)
        expect(answer).to be_valid
      end

      context "with valid parameters" do
        it "creates a new Answer" do
          expect {
            post answers_url, params: { answer: @valid_attributes }
          }.to change{ Answer.count }.by(1)
        end

        it "redirects to the chat room you answered" do
          post answers_url, params: { answer: @valid_attributes }
          expect(response).to redirect_to(room_url(@room))
        end
      end

      context "with invalid parameters" do
        before do
          @invalid_attributes = { body: nil, room_id: @room.id, post_id: @post.id, user_id: @answerer.id }
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

    context "as a guest" do
      it "returns a 302 response" do
        post answers_url, params: { answer: @valid_attributes }
        expect(response).to have_http_status "302"
      end

      it "redirect to the sign-in page" do
        post answers_url, params: { answer: @valid_attributes }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
