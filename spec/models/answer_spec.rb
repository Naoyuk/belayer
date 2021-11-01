require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:owner) { FactoryBot.create(:user) }
  let(:post) { owner.posts.create }
  let(:answer) { post.answers.build(body: 'Text', user_id: user.id) }

  it 'has a valid factory' do
    expect(answer).to be_valid
  end

  describe 'validates for parameters' do
    context 'when with valid params' do
      it 'is valid' do
        expect(answer).to be_valid
      end
    end

    context 'when without body' do
      it 'is invalid' do
        answer.body = nil
        expect(post).to_not be_valid
      end
    end
  end
end
