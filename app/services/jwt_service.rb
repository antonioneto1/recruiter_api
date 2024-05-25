require 'jwt'

class JwtService
  # Método para codificar um payload em um token JWT
  def self.encode(payload)
    JWT.encode(payload, Rails.application.credentials.devise_jwt_secret_key, 'HS256')
  end

  # Método para decodificar um token JWT em um payload
  def self.decode(token)
    JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key, true, algorithm: 'HS256')
  end
end
