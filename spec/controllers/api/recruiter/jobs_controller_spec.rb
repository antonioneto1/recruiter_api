RSpec.describe Api::Recruiter::JobsController, type: :controller do
  let(:recruiter) { create(:recruiter) }
  let(:job) { create(:job, recruiter: recruiter) }

  before do
    sign_in recruiter
  end

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns all jobs to @jobs" do
      jobs = create_list(:job, 3, recruiter: recruiter)
      get :index
      expect(assigns(:jobs)).to match_array(jobs)
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      get :show, params: { id: job.id }
      expect(response).to be_successful
    end

    it "assigns the requested job to @job" do
      get :show, params: { id: job.id }
      expect(assigns(:job)).to eq job
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new job" do
        expect {
          post :create, params: { job: attributes_for(:job) }
        }.to change(Job, :count).by(1)
      end

      it "returns a created status" do
        post :create, params: { job: attributes_for(:job) }
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new job" do
        expect {
          post :create, params: { job: attributes_for(:job, title: nil) }
        }.to_not change(Job, :count)
      end

      it "returns an unprocessable entity status" do
        post :create, params: { job: attributes_for(:job, title: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "updates the requested job" do
        new_title = "New Title"
        patch :update, params: { id: job.id, job: { title: new_title } }
        job.reload
        expect(job.title).to eq(new_title)
      end

      it "returns a successful response" do
        patch :update, params: { id: job.id, job: { title: "New Title" } }
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "returns an unprocessable entity status" do
        patch :update, params: { id: job.id, job: { title: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested job" do
      job_to_delete = create(:job, recruiter: recruiter)
      expect {
        delete :destroy, params: { id: job_to_delete.id }
      }.to change(Job, :count).by(-1)
    end

    it "returns a no content status" do
      delete :destroy, params: { id: job.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
