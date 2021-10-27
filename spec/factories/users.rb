FactoryBot.define do
  factory :user, aliases: [:owner] do
    email { "test@example.com" }
    password { "123456" }
    password_confirmation { "123456" }
    name { "Test" }
  end
end
