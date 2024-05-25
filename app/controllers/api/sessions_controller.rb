class Api::SessionsController < ApplicationController
  def sign_user
    recruiter = Recruiter.find_by(email: params[:email])
    if recruiter && recruiter.valid_password?(params[:password])
      token = AuthenticationService.encode({ recruiter_id: recruiter.id })
      render json: { message: 'Login successful', token: token }, status: :created, headers: { 'Authorization' => token }
    else
      render json: { error: 'Invalid email or password' }, status: :unprocessable_entity
    end
  end
end
