class Api::Public::SubmissionsController < ApplicationController
  def create
    @submission = Submission.new(submission_params)

    if Submission.exists?(email: @submission.email, job_id: @submission.job_id)
      render json: { error: 'You have already applied for this job' }, status: :unprocessable_entity
    elsif @submission.save
      render :show, status: :created
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  def show
    @submission = Submission.find(params[:id])
    render json: @submission
  end

  private

  def submission_params
    params.require(:submission).permit(:name, :email, :mobile_phone, :resume, :job_id)
  end
end
