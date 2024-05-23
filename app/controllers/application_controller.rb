class ApplicationController < ActionController::API
  def authenticate_recruiter!
    token = request.headers['Authorization']&.split(' ')&.last
    decoded_token = AuthenticationService.decode(token)
    if decoded_token && @current_recruiter = Recruiter.find_by(id: decoded_token[:recruiter_id])
      @current_recruiter
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
