require 'rails_helper'

RSpec.describe "Posts", type: :request do
  
  let(:valid_attributes) {
    {
      date: Date.new.strftime("%Y-%m-%d"),
      start_time: Time.new.strftime("%H:%M"),
      end_time: Time.new.strftime("%H:%M"),
      kind_of_climbing: :sport,
      describe: 'test test'
    }
  }

  let(:invalid_attributes) {
    {
      date: nil,
      start_time: nil,
      end_time: nil,
      kind_of_climbing: nil,
      describe: nil
    }
  }

  let(:user) { FactoryBot.create(:user) }

  describe "GET /index" do
    context 'as an authenticated user' do
      before do
        sign_in user
        @post = FactoryBot.create(:post, user: user)
      end

      it "renders a successful response" do
        get posts_url
        expect(response).to be_successful
      end

      it "returns a 200 response" do
        get posts_url
        expect(response).to have_http_status "200"
      end
    end

    context 'as a guest' do
      it "returns a 302 response" do
        get posts_url
        expect(response).to have_http_status "302"
      end

      it "redirect to the sign-in page" do
        get posts_url
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "GET /show" do
    context 'as an authenticated user' do
      before do
        sign_in user
        @post = FactoryBot.create(:post, user: user)
      end

      it "renders a successful response" do
        get post_url(@post)
        expect(response).to be_successful
      end
    end

    context 'as a guest' do
      before do
        @post = FactoryBot.create(:post, user: user)
      end

      it "returns a 302 response" do
        get post_url(@post)
        expect(response).to have_http_status "302"
      end

      it "redirect to the sign-in page" do
        get post_url(@post)
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "GET /new" do
    context 'as an authenticated user' do
      before do
        sign_in user
        @post = FactoryBot.create(:post, user: user)
      end

      it "renders a successful response" do
        get new_post_url
        expect(response).to be_successful
      end
    end

    context 'as a guest' do
      it "returns a 302 response" do
        get new_post_url
        expect(response).to have_http_status "302"
      end

      it "redirect to the sign-in page" do
        get new_post_url
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "GET /edit" do
    context 'as an authenticated user' do
      before do
        sign_in user
        @post = FactoryBot.create(:post, user: user)
      end

      it "render a successful response" do
        get edit_post_url(@post)
        expect(response).to be_successful
      end
    end

    context 'as a guest' do
      before do
        @post = FactoryBot.create(:post, user: user)
      end

      it "returns a 302 response" do
        get edit_post_url(@post)
        expect(response).to have_http_status "302"
      end

      it "redirect to the sign-in page" do
        get edit_post_url(@post)
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "POST /create" do
    context 'as an authenticated user' do
      before do
        sign_in user
        @post = FactoryBot.create(:post, user: user)
      end

      context "with valid parameters" do
        it "creates a new Post" do
          sign_in user
          expect {
            post posts_url, params: { post: valid_attributes, user: user }
          }.to change(Post, :count).by(1)
        end

        it "redirects to the created post" do
          sign_in user
          post posts_url, params: { post: valid_attributes, user: user }
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
  end

  describe "PATCH /update" do
    context 'as an authenticated user' do
      before do
        sign_in user
        @post = FactoryBot.create(:post, user: user)
      end

      context "with valid parameters" do

        let(:new_attributes) {
          {
            date: Date.tomorrow.strftime("%Y-%m-%d"),
            start_time: Date.tomorrow.strftime("%H:%M"),
            end_time: Date.tomorrow.strftime("%H:%M"),
            kind_of_climbing: :multi_pitches
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
  end

  describe "DELETE /destroy" do
    context 'as an authenticated user' do
      before do
        sign_in user
        @post = FactoryBot.create(:post, user: user)
      end

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
end
