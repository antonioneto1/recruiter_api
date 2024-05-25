require 'rails_helper'

RSpec.describe 'Api::RecruiterApi::Jobs', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:recruiter) { create(:recruiter) }
  let(:job) { create(:job, recruiter: recruiter) }

  before do
    sign_in recruiter
  end

  describe 'GET /api/recruiter_api/jobs' do
    it 'returns a successful response' do
      get '/api/recruiter_api/jobs', headers: { 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
    end

    it 'assigns all jobs to @jobs' do
      jobs = create_list(:job, 3, recruiter: recruiter)
      get '/api/recruiter_api/jobs', headers: { 'ACCEPT' => 'application/json' }
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(3)
    end
  end

  describe 'GET /api/recruiter_api/jobs/:id' do
    it 'returns a successful response' do
      get "/api/recruiter_api/jobs/#{job.id}", headers: { 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
    end

    it 'assigns the requested job to @job' do
      get "/api/recruiter_api/jobs/#{job.id}", headers: { 'ACCEPT' => 'application/json' }
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(job.id)
    end
  end

  describe 'POST /api/recruiter_api/jobs' do
    context 'with valid parameters' do
      let(:valid_params) { { job: attributes_for(:job) } }

      it 'creates a new job' do
        expect {
          post 'api/recruiter_api/jobs', params: valid_params, headers: authenticated_header(recruiter)
        }.to change(Job, :count).by(1)
      end

      it 'returns a created status' do
        byebug
        post '/api/recruiter_api/jobs', params: valid_params, headers: authenticated_header(recruiter)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { job: attributes_for(:job, title: nil) } }

      it 'does not create a new job' do
        expect {
          post '/api/recruiter_api/jobs', params: invalid_params, headers: { 'ACCEPT' => 'application/json' }
        }.not_to change(Job, :count)
      end

      it 'returns an unprocessable entity status' do
        post '/api/recruiter_api/jobs', params: invalid_params, headers: { 'ACCEPT' => 'application/json' }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /api/recruiter_api/jobs/:id' do
    context 'with valid parameters' do
      let(:new_title) { 'New Title' }
      let(:valid_params) { { job: { title: new_title } } }

      it 'updates the requested job' do
        patch "/api/recruiter_api/jobs/#{job.id}", params: valid_params, headers: { 'ACCEPT' => 'application/json' }
        job.reload
        expect(job.title).to eq(new_title)
      end

      it 'returns a successful response' do
        patch "/api/recruiter_api/jobs/#{job.id}", params: valid_params, headers: { 'ACCEPT' => 'application/json' }
        expect(response).to be_successful
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { job: { title: nil } } }

      it 'returns an unprocessable entity status' do
        patch "/api/recruiter_api/jobs/#{job.id}", params: invalid_params, headers: { 'ACCEPT' => 'application/json' }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /api/recruiter_api/jobs/:id' do
    it 'destroys the requested job' do
      job_to_delete = create(:job, recruiter: recruiter)
      expect {
        delete "/api/recruiter_api/jobs/#{job_to_delete.id}", headers: { 'ACCEPT' => 'application/json' }
      }.to change(Job, :count).by(-1)
    end

    it 'returns a no content status' do
      delete "/api/recruiter_api/jobs/#{job.id}", headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(:no_content)
    end
  end

  private

  def authenticated_header(recruiter)
    token = JwtService.encode(user_id: recruiter.id)
    { 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{token}" }
  end
end
