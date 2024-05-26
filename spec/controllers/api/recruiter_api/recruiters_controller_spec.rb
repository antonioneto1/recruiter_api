require 'rails_helper'

RSpec.describe Api::RecruiterApi::RecruitersController, type: :controller do
  let(:recruiter) { create(:recruiter) }

  before do
    request.headers.merge!(authenticated_header(recruiter))
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index, format: :json
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: recruiter.id }, format: :json
      expect(response).to be_successful
    end

    it 'assigns the requested recruiter to @recruiter' do
      get :show, params: { id: recruiter.id }, format: :json
      expect(assigns(:recruiter)).to eq recruiter
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new recruiter' do
        expect {
          post :create, params: { recruiter: attributes_for(:recruiter) }, format: :json
        }.to change(Recruiter, :count).by(1)
      end

      it 'returns a created status' do
        post :create, params: { recruiter: attributes_for(:recruiter) }, format: :json
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new recruiter' do
        expect {
          post :create, params: { recruiter: attributes_for(:recruiter, name: nil) }, format: :json
        }.to_not change(Recruiter, :count)
      end

      it 'returns an unprocessable entity status' do
        post :create, params: { recruiter: attributes_for(:recruiter, name: nil) }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested recruiter' do
      recruiter_to_delete = create(:recruiter)
      expect {
        delete :destroy, params: { id: recruiter_to_delete.id }, format: :json
      }.to change(Recruiter, :count).by(-1)
    end

    it 'returns a no content status' do
      delete :destroy, params: { id: recruiter.id }, format: :json
      expect(response).to have_http_status(:no_content)
    end
  end

  private

  def authenticated_header(recruiter)
    token = AuthenticationService.encode(recruiter_id: recruiter.id)
    { 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{token}" }
  end
end
