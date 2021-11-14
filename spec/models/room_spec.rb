require 'rails_helper'

RSpec.describe Room, type: :model do
  it 'has a valid factory' do
    room = FactoryBot.build(:room)
    expect(room).to be_valid
  end
end
