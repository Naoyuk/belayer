FactoryBot.define do
  factory :answer do
    body { "MyText" }
    read { false }
    snoozed_at { "2021-10-29 18:47:29" }
    association :user
    association :room
    association :post
  end
end
