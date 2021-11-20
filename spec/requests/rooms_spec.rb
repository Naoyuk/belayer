require 'rails_helper'

RSpec.describe "Rooms", type: :request do

  before do
    @user = FactoryBot.create(:user)
    @answerer = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)
    @room = Room.create(
      post_id: @post.id,
      host_user_id: @user.id,
      answerer_user_id: @answerer.id
    )
    @answer = Answer.create(
      post_id: @post.id,
      user_id: @answerer.id,
      room_id: @room.id,
      body: "test text"
    )
  end

  describe "GET /index" do
    context "as an authenticated user" do
      before do
        sign_in @user
      end

      it "returns successful response" do
        get rooms_url
        expect(response).to be_successful
      end

      it "returns a 200 response" do
        get rooms_url
        expect(response).to have_http_status "200"
      end
    end

    context "as a guest" do
      it "returns 302 response" do
        get rooms_url
        expect(response).to have_http_status "302"
      end

      it "redirect to the sign-in page" do
        get rooms_url
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "GET /show" do
    context "as an authenticated user" do
      before do
        @other_answer = Answer.create(
          post_id: @post.id,
          user_id: @user.id,
          room_id: @room.id,
          body: "test text2"
        )
      end

      it "returns successful response" do
        sign_in @user
        get room_url(@room)
        expect(response).to be_successful
      end

      it "returns a 200 response" do
        sign_in @user
        get room_url(@room)
        expect(response).to have_http_status "200"
      end

      it "makes all messages related the room you open read status" do
        sign_in @answerer
        get room_url(@room)
        expect(Answer.first.read).to eq true
        expect(Answer.last.read).to eq true
      end
    end

    context "as a guest" do
      it "returns 302 response" do
        get room_url(@room)
        expect(response).to have_http_status "302"
      end

      it "redirect to the sign-in page" do
        get room_url(@room)
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
