class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    token = request.headers['Authorization']
    decoded_token = AuthenticationService.decode(token)
    if decoded_token.nil?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    else
      @current_user = User.find(decoded_token['user_id'])
    end
  end
end
