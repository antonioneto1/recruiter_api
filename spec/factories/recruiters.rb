FactoryBot.define do
  factory :recruiter do
    name { 'John Doe' }
    email { Faker::Internet.unique.email }
    password { '123456' }
  end
end
