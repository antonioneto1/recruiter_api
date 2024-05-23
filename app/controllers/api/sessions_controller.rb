# app/controllers/api/sessions_controller.rb
class Api::SessionsController < ApplicationController
  def create
    recruiter = Recruiter.find_by(email: params[:email])
    if recruiter&.authenticate(params[:password])
      token = AuthenticationService.encode({ recruiter_id: recruiter.id })
      render json: { token: token }, status: :created
    else
      render json: { error: 'Invalid email or password' }, status: :unprocessable_entity
    end
  end
end
