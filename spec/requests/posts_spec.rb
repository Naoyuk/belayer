require 'rails_helper'

RSpec.describe "/posts", type: :request do
  
  let(:valid_attributes) {
    {
      date: Date.new.strftime("%Y-%m-%d"),
      start_time: Time.new.strftime("%H:%M"),
      end_time: Time.new.strftime("%H:%M"),
      kind_of_climbing: 0,
      describe: 'test test'
    }
  }

  let(:invalid_attributes) {
    {
      date: nil,
      start_time: nil,
      end_time: nil,
      kind_of_climbing: 0,
      describe: nil
    }
  }

  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    @post = FactoryBot.create(:post, user_id: user.id)
  end



  describe "GET /index" do
    it "renders a successful response" do
      get posts_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get post_url(@post)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_post_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      get edit_post_url(@post)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Post" do
        pending("TODO: Use post method and association at the same time")
        expect {
          post posts_url, params: { post: valid_attributes }
        }.to change(Post, :count).by(1)
      end

      it "redirects to the created post" do
        pending("TODO: Use post method and association at the same time")
        post posts_url, params: { post: valid_attributes }
        expect(response).to redirect_to(post_url(Post.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Post" do
        expect {
          post posts_url, params: { post: invalid_attributes }
        }.to change(Post, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post posts_url, params: { post: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do

      let(:new_attributes) {
        {
          date: Date.tomorrow.strftime("%Y-%m-%d"),
          start_time: Date.tomorrow.strftime("%H:%M"),
          end_time: Date.tomorrow.strftime("%H:%M"),
          kind_of_climbing: 0
        }
      }

      it "updates the requested post" do
        patch post_url(@post), params: { post: new_attributes }
        @post.reload
        expect(response).to redirect_to(post_url(@post))
      end

      it "redirects to the post" do
        patch post_url(@post), params: { post: new_attributes }
        @post.reload
        expect(response).to redirect_to(post_url(@post))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch post_url(@post), params: { post: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested post" do
      expect {
        delete post_url(@post)
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      delete post_url(@post)
      expect(response).to redirect_to(posts_url)
    end
  end
end
