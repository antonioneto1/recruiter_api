RSpec.describe Api::Public::JobsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @jobs with active jobs' do
      active_jobs = create_list(:job, 3, status: 'active')
      get :index
      expect(assigns(:jobs)).to match_array(active_jobs)
    end

    it 'filters jobs by title if title param is present' do
      job_with_title = create(:job, title: 'Ruby Developer', status: 'active')
      get :index, params: { title: 'Ruby' }
      expect(assigns(:jobs)).to eq [job_with_title]
    end
  end

  describe 'GET #show' do
    let(:job) { create(:job) }

    it 'returns a successful response' do
      get :show, params: { id: job.id }
      expect(response).to be_successful
    end

    it 'assigns the requested job to @job' do
      get :show, params: { id: job.id }
      expect(assigns(:job)).to eq job
    end
  end
end
