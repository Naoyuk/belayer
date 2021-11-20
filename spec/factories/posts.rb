FactoryBot.define do
  factory :post do
    date { Date.new.strftime("%Y-%m-%d") }
    start_time { Time.new.strftime("%H:%M") }
    end_time { Time.new.strftime("%H:%M") }
    kind_of_climbing { :bouldering }
    sequence(:describe) { |n| "test test#{n}" }
    association :user

    trait :invalid do
      date { nil }
    end

    trait :new_attributes do
      date { Date.tomorrow.strftime("%Y-%m-%d") }
      start_time { Date.tomorrow.strftime("%H:%M") }
      end_time { Date.tomorrow.strftime("%H:%M") }
      kind_of_climbing { :multi_pitches }
    end
  end
end
