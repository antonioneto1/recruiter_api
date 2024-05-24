FactoryBot.define do
  factory :job do
    title { 'Software Developer' }
    description { 'Develop and maintain web applications.' }
    start_date { '2024-06-01' }
    end_date { '2024-12-31' }
    skills { 'Ruby, Rails, JavaScript' }

    association :recruiter
  end
end