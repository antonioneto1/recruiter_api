class Api::RecruiterApi::JobsController < ApplicationController
  before_action :authenticate_recruiter!, except: %i[index show]
  before_action :set_recruiter
  before_action :set_job, only: %i[show update destroy]

  # GET /jobs
  def index
    @jobs = Job.all
    render :index
  end

  # GET /jobs/1
  def show
    render :show
  end

  # POST /jobs
  def create
    @job = @current_recruiter.jobs.new(job_params)

    if @job.save
      render :show
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  def update
    if @job.update(job_params)
      render :show
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # DELETE /jobs/1
  def destroy
    @job.destroy
    head :no_content
  end

  private

  def set_recruiter
    @current_recruiter
  end

  def set_job
    @job = Job.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def job_params
    params.require(:job).permit(:title, :description, :start_date, :end_date, :status, :skills)
  end
end
