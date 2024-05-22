class Api::RecruitersController < ApplicationController
  before_action :set_recruiter, only: %i[ show edit update destroy ]

  # GET /recruiters or /recruiters.json
  def index
    @recruiters = Recruiter.all
  end

  # GET /recruiters/1 or /recruiters/1.json
  def show
  end

  # GET /recruiters/new
  def new
    @recruiter = Recruiter.new
  end

  # GET /recruiters/1/edit
  def edit
  end

  # POST /recruiters or /recruiters.json
  def create
    @recruiter = Recruiter.new(recruiter_params)

    respond_to do |format|
      if @recruiter.save
        format.html { redirect_to recruiter_url(@recruiter), notice: "Recruiter was successfully created." }
        format.json { render :show, status: :created, location: @recruiter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recruiter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recruiters/1 or /recruiters/1.json
  def update
    respond_to do |format|
      if @recruiter.update(recruiter_params)
        format.html { redirect_to recruiter_url(@recruiter), notice: "Recruiter was successfully updated." }
        format.json { render :show, status: :ok, location: @recruiter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recruiter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recruiters/1 or /recruiters/1.json
  def destroy
    @recruiter.destroy

    respond_to do |format|
      format.html { redirect_to recruiters_url, notice: "Recruiter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recruiter
      @recruiter = Recruiter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recruiter_params
      params.require(:recruiter).permit(:name, :email, :password)
    end
end
