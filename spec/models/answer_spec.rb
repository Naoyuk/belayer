require 'rails_helper'

RSpec.describe Answer, type: :model do
  before do
    user = FactoryBot.create(:user)
    answerer = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
    room = @post.rooms.create(host_user_id: user.id, answerer_user_id: answerer.id)
    @answer = room.answers.build(body: 'Text', post_id: @post.id, user_id: answerer.id)
  end

  it 'has a valid factory' do
    expect(@answer).to be_valid
  end

  describe 'validates for parameters' do
    it 'is valid with valid params' do
      expect(@answer).to be_valid
    end

    it 'is invalid without body' do
      @answer.body = nil
      expect(@answer).to_not be_valid
    end
  end
end
