require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.build(:post, user_id: user.id) }

  it 'has a valid factory' do
    expect(post).to be_valid
  end

  describe 'validates for parameters' do
    it 'is valid with date, start_time, end_time and kind_of_climbing' do
      expect(post).to be_valid
    end

    it 'is invalid without date' do
      post.date = nil

      expect(post).to_not be_valid
      expect(post.errors[:date]).to include("can't be blank")
    end

    it 'is invalid without start_time' do
      post.start_time = nil

      expect(post).to_not be_valid
      expect(post.errors[:start_time]).to include("can't be blank")
    end

    it 'is invalid without end_time' do
      post.end_time = nil

      expect(post).to_not be_valid
      expect(post.errors[:end_time]).to include("can't be blank")
    end
  end

end
