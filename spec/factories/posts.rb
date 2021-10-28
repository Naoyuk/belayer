FactoryBot.define do
  factory :post do
    date { Date.new.strftime("%Y-%m-%d") }
    start_time { Time.new.strftime("%H:%M") }
    end_time { Time.new.strftime("%H:%M") }
    kind_of_climbing { 0 }
    sequence(:describe) { |n| "test test#{n}" }
  end
end
