require 'rails_helper'

RSpec.describe Api::Public::SubmissionsController, type: :controller do
  describe 'POST #create' do
    context 'when submission params are valid' do
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

      it 'creates a new submission' do
        post :create, params: { submission: attributes_for(:submission) }
        expect(response).to have_http_status(:created)
        expect(Submission.count).to eq(1)
      end

      it 'renders the created submission as JSON' do
        post :create, params: { submission: attributes_for(:submission) }
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['id']).to be_present
      end
    end
  end
end
