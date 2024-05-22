class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = AuthenticationService.encode({ user_id: user.id })
      render json: { token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unprocessable_entity
    end
  end
end
