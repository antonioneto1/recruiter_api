RSpec.describe Api::RecruiterApi::RecruitersController, type: :controller do
  let(:recruiter) { create(:recruiter) }

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns all recruiters to @recruiters" do
      recruiters = create_list(:recruiter, 3)
      get :index
      expect(assigns(:recruiters)).to match_array(recruiters)
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      get :show, params: { id: recruiter.id }
      expect(response).to be_successful
    end

    it "assigns the requested recruiter to @recruiter" do
      get :show, params: { id: recruiter.id }
      expect(assigns(:recruiter)).to eq recruiter
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new recruiter" do
        expect {
          post :create, params: { recruiter: attributes_for(:recruiter) }
        }.to change(Recruiter, :count).by(1)
      end

      it "returns a created status" do
        post :create, params: { recruiter: attributes_for(:recruiter) }
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new recruiter" do
        expect {
          post :create, params: { recruiter: attributes_for(:recruiter, name: nil) }
        }.to_not change(Recruiter, :count)
      end

      it "returns an unprocessable entity status" do
        post :create, params: { recruiter: attributes_for(:recruiter, name: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "updates the requested recruiter" do
        new_name = "Jonh Doe"
        patch :update, params: { id: recruiter.id, recruiter: { name: new_name } }
        recruiter.reload
        expect(recruiter.name).to eq(new_name)
      end

      it "returns a successful response" do
        patch :update, params: { id: recruiter.id, recruiter: { name: "New Name" } }
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "returns an unprocessable entity status" do
        patch :update, params: { id: recruiter.id, recruiter: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested recruiter" do
      recruiter_to_delete = create(:recruiter)
      expect {
        delete :destroy, params: { id: recruiter_to_delete.id }
      }.to change(Recruiter, :count).by(-1)
    end

    it "returns a no content status" do
      delete :destroy, params: { id: recruiter.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
