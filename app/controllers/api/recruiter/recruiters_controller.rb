# app/controllers/api/recruiter/recruiters_controller.rb
class Api::Recruiter::RecruitersController < ApplicationController
  before_action :set_recruiter, only: %i[show update destroy]
  before_action :authenticate_recruiter!, except: [:create]

  # GET /recruiters
  def index
    @recruiters = Recruiter.all
    render :index
  end

  # GET /recruiters/1
  def show
    render json: @recruiter
  end

  # POST /recruiters
  def create
    @recruiter = Recruiter.new(recruiter_params)

    if @recruiter.save
      render json: @recruiter, status: :created, location: api_recruiter_recruiter_url(@recruiter)
    else
      render json: @recruiter.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recruiters/1
  def update
    if @recruiter.update(recruiter_params)
      render json: @recruiter
    else
      render json: @recruiter.errors, status: :unprocessable_entity
    end
  end

  # DELETE /recruiters/1
  def destroy
    @recruiter.destroy
    head :no_content
  end

  private

  def set_recruiter
    @recruiter = Recruiter.find(params[:id])
  end

  def recruiter_params
    params.require(:recruiter).permit(:name, :email, :password)
  end
end
