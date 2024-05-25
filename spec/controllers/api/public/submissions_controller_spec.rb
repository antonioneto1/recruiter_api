require 'rails_helper'

RSpec.describe 'Api::Public::Submissions', type: :request do
  describe 'POST /api/public/submissions' do
    let(:recruiter) { create(:recruiter) }
    let(:job) { create(:job, recruiter: recruiter) }
    let(:valid_params) do
      {
        submission: {
          name: 'John Doe',
          email: 'john.doe@example.com',
          mobile_phone: '123456789',
          resume: fixture_file_upload('files/resume.pdf', 'application/pdf'),
          job_id: job.id
        }
      }
    end

    context 'when submission params are valid' do
      it 'creates a new submission' do
        expect {
          post '/api/public/submissions', params: valid_params, headers: { 'ACCEPT' => 'application/json' }
        }.to change(Submission, :count).by(1)
        expect(response).to have_http_status(:created)
      end

      it 'renders the created submission as JSON' do
        post '/api/public/submissions', params: valid_params, headers: { 'ACCEPT' => 'application/json' }
        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response).not_to be_empty
        expect(json_response['id']).to be_present
      end
    end

    context 'when submission params are invalid' do
      let(:invalid_params) do
        {
          submission: {
            name: '',
            email: 'john.doe@example.com',
            mobile_phone: '123456789',
            resume: nil,
            job_id: nil
          }
        }
      end

      it 'does not create a new submission' do
        expect {
          post '/api/public/submissions', params: invalid_params, headers: { 'ACCEPT' => 'application/json' }
        }.not_to change(Submission, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when creating multiple submissions for the same job' do
      let(:valid_params) do
        {
          submission: {
            name: 'John Doe',
            email: 'john.doe@example.com',
            mobile_phone: '123456789',
            resume: fixture_file_upload('files/resume.pdf', 'application/pdf'),
            job_id: job.id
          }
        }
      end

      it 'allows multiple submissions for different candidates' do
        expect {
          post '/api/public/submissions', params: valid_params, headers: { 'ACCEPT' => 'application/json' }
        }.to change(Submission, :count).by(1)
        expect(response).to have_http_status(:created)

        second_submission_params = valid_params.deep_dup
        second_submission_params[:submission][:email] = 'jane.doe@example.com'

        expect {
          post '/api/public/submissions', params: second_submission_params, headers: { 'ACCEPT' => 'application/json' }
        }.to change(Submission, :count).by(1)
        expect(response).to have_http_status(:created)
      end

      it 'prevents duplicate submissions for the same candidate and job' do
        post '/api/public/submissions', params: valid_params, headers: { 'ACCEPT' => 'application/json' }
        expect(response).to have_http_status(:created)

        expect {
          post '/api/public/submissions', params: valid_params, headers: { 'ACCEPT' => 'application/json' }
        }.not_to change(Submission, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
