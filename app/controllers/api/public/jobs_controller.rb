# app/controllers/api/public/jobs_controller.rb
class Api::Public::JobsController < ApplicationController
  def index
    @jobs = Job.where(status: 'active')
    @jobs = @jobs.where('title ILIKE ?', "%#{params[:title]}%") if params[:title].present?
    @jobs = @jobs.where('description ILIKE ?', "%#{params[:description]}%") if params[:description].present?
    @jobs = @jobs.where('skills ILIKE ?', "%#{params[:skills]}%") if params[:skills].present?
    render :index
  end

  def show
    @job = Job.find(params[:id])
    render :show
  end
end
