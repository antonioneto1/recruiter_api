require 'rails_helper'

RSpec.describe 'Api::Public::Jobs', type: :request do
  describe 'GET /api/public/jobs' do
    it 'returns a success response' do
      get '/api/public/jobs', headers: { 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns all jobs when no search parameters are provided' do
      job1 = create(:job, status: 'active')
      job2 = create(:job, status: 'active')
      get '/api/public/jobs', headers: { 'ACCEPT' => 'application/json' }
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'returns jobs matching the title search parameter' do
      job1 = create(:job, title: 'Ruby Developer', status: 'active')
      job2 = create(:job, title: 'Python Developer', status: 'active')
      get '/api/public/jobs', params: { title: 'Ruby' }, headers: { 'ACCEPT' => 'application/json' }
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body).first['title']).to eq('Ruby Developer')
    end

    it 'returns jobs matching the description search parameter' do
      job1 = create(:job, description: 'Backend Developer', status: 'active')
      job2 = create(:job, description: 'Frontend Developer', status: 'active')
      get '/api/public/jobs', params: { description: 'Backend' }, headers: { 'ACCEPT' => 'application/json' }
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body).first['description']).to eq('Backend Developer')
    end

    it 'returns jobs matching the skills search parameter' do
      job1 = create(:job, skills: 'Ruby, Rails', status: 'active')
      job2 = create(:job, skills: 'Python, Django', status: 'active')
      get '/api/public/jobs', params: { skills: 'Ruby' }, headers: { 'ACCEPT' => 'application/json' }
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body).first['skills']).to eq('Ruby, Rails')
    end
  end

  describe 'GET /api/public/jobs/:id' do
    it 'returns a success response' do
      job = create(:job)
      get "/api/public/jobs/#{job.id}", headers: { 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end
end
