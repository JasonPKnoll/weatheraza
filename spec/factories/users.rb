FactoryBot.define do
  factory :user do
    email { "example@email.com" }
    password { "hunter2" }
    password_confirmation { "hunter2" }
  end
end
