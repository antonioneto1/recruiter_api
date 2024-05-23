class Api::SubmissionsController < ApplicationController
  before_action :set_submission, only: %i[show update destroy]

  # GET /submissions
  def index
    @submissions = Submission.all
    render :index
  end

  # GET /submissions/1
  def show
    render :show
  end

  # POST /submissions
  def create
    @submission = Submission.new(submission_params)

    if @submission.save
      render :show, status: :created, location: api_submission_url(@submission)
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /submissions/1
  def update
    if @submission.update(submission_params)
      render :show, status: :ok, location: api_submission_url(@submission)
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  # DELETE /submissions/1
  def destroy
    @submission.destroy
    head :no_content
  end

  private

  def set_submission
    @submission = Submission.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(:name, :email, :mobile_phone, :resume, :job_id)
  end
end
