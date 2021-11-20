FactoryBot.define do
  factory :room do
    host_user_id { 1 }
    answerer_user_id { 1 }
    association :post
  end
end
