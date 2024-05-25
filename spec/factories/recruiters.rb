FactoryBot.define do
  factory :recruiter do
    name { 'John Doe' }
    email { Faker::Internet.unique.email }
    password_digest { BCrypt::Password.create('123456') }
    password { '123456' }
  end
end
