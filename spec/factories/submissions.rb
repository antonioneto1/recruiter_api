FactoryBot.define do
  factory :submission do
    name { 'John Doe' }
    email { 'john@example.com' }
    mobile_phone { '123456789' }
    resume { Rack::Test::UploadedFile.new('fixtures/files/resume.pdf', 'application/pdf') }
    job_id { 1 }
  end
end
