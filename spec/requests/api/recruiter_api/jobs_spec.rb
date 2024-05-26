require 'rails_helper'

RSpec.describe 'Api::RecruiterApi::Jobs', type: :request do
  let(:recruiter) { create(:recruiter) }
  let(:valid_params) { { job: { title: 'New Job', description: 'Job description', start_date: '2024-06-01', end_date: '2024-06-30', status: 'active' } } }

  describe 'POST /api/recruiter_api/jobs' do
    context 'with valid parameters' do
      it 'creates a new job' do
        post '/api/recruiter_api/jobs', params: valid_params, headers: authenticated_header(recruiter)
        expect(response).to have_http_status(200)
        expect(response.body).to include('New Job')
      end
    end

    context 'with invalid parameters' do
      it 'returns an error' do
        invalid_params = { job: { title: '', description: 'Job description', start_date: '2024-06-01', end_date: '2024-06-30', status: 'active' } }
        post '/api/recruiter_api/jobs', params: invalid_params, headers: authenticated_header(recruiter)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'without authentication' do
      it 'returns an unauthorized status' do
        post '/api/recruiter_api/jobs', params: valid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  private

  def authenticated_header(recruiter)
    token = AuthenticationService.encode(recruiter_id: recruiter.id)
    { 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{token}" }
  end
end
