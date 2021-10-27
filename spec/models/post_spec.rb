require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validates for parameters' do
    before do
      user = User.create(
        name: 'Test',
        email: 'test@example.com',
        password: '123456',
        password_confirmation: '123456'
      )
      @post = user.posts.build(
        date: Date.today.strftime("%Y-%m-%d"),
        start_time: Time.new.strftime("%H:%M"),
        end_time: Time.new.strftime("%H:%M"),
        kind_of_climbing: 0,
        describe: 'test test'
      )
    end

    context 'when with date, start_time, end_time and kind_of_climgin' do
      it 'is valid' do
        expect(@post).to be_valid
      end
    end

    context 'when without date is invalid' do
      it 'is invalid' do
        @post.date = nil

        expect(@post).to_not be_valid
        expect(@post.errors[:date]).to include("can't be blank")
      end
    end

    context 'when without start_time is invalid' do
      it 'is invalid' do
        @post.start_time = nil

        expect(@post).to_not be_valid
        expect(@post.errors[:start_time]).to include("can't be blank")
      end
    end

    context 'when without end_time is invalid' do
      it 'is invalid' do
        @post.end_time = nil

        expect(@post).to_not be_valid
        expect(@post.errors[:end_time]).to include("can't be blank")
      end
    end
  end

end
