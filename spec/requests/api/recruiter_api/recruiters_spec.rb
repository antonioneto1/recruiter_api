require 'rails_helper'

RSpec.describe 'Api::RecruiterApi::Recruiters', type: :request do
  let(:recruiter) { create(:recruiter) }
  let(:valid_params) { { recruiter: attributes_for(:recruiter) } }

  describe 'GET /api/recruiter_api/recruiters' do
    it 'returns a successful response' do
      get '/api/recruiter_api/recruiters', headers: authenticated_header(recruiter)
      expect(response).to be_successful
    end
  end

  describe 'GET /api/recruiter_api/recruiters/:id' do
    it 'returns a successful response' do
      get "/api/recruiter_api/recruiters/#{recruiter.id}", headers: authenticated_header(recruiter)
      expect(response).to be_successful
    end
  end

  describe 'POST /api/recruiter_api/recruiters' do
    context 'with valid parameters' do
      it 'creates a new recruiter' do
        expect {
          post '/api/recruiter_api/recruiters', params: valid_params, headers: authenticated_header(recruiter)
        }.to change(Recruiter, :count).by(2)
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new recruiter' do
        post '/api/recruiter_api/recruiters', params: { recruiter: attributes_for(:recruiter, name: nil, email: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  private

  def authenticated_header(recruiter)
    token = AuthenticationService.encode(recruiter_id: recruiter.id)
    { 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{token}" }
  end
end
