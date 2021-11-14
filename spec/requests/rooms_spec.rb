require 'rails_helper'

RSpec.describe "Rooms", type: :request do

  before do
    @user = FactoryBot.create(:user)
    @answerer = FactoryBot.create(:user)
    @post = Post.create(
      user_id: @user.id,
      date: Date.new.strftime("%Y-%m-%d"),
      start_time: Time.new.strftime("%h:%m"),
      end_time: Time.new.strftime("%h:%m"),
      kind_of_climbing: 0,
      describe: "test test"
    )
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
    # @answer = @room.answers.create(user_id: @answerer.id, post_id: @post.id)
  end

  describe "GET /index" do
    it "returns http success" do
      sign_in @user
      get rooms_url
      expect(response).to have_http_status(:success)
    end
  end

end
