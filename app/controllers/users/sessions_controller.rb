# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json
  private
  def respond_with(current_user, _opts = {})
    render json: {
      status: { 
        code: 200, message: 'Logged in successfully.',
        data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes],
                all_users: UserSerializer.new(User.where(admin: nil)).serializable_hash[:data].map { |user| user[:attributes] }
      },
      token: generate_jwt_token(current_user)
      }
    }, status: :ok
  end
  
  def respond_to_on_destroy
    current_user = nil
  
    if request.headers['Authorization'].present?
      begin
        # Decode the JWT and get the payload
        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
        current_user = User.find(jwt_payload['sub'])
      rescue JWT::ExpiredSignature
        # Handle expired token
        return render json: {
          status: 401,
          message: 'Session has expired. Please log in again.'
        }, status: :unauthorized
      rescue JWT::DecodeError
        # Handle other decoding errors
        return render json: {
          status: 401,
          message: 'Invalid token. Please log in again.'
        }, status: :unauthorized
      end
    end
  
    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
  

  def generate_jwt_token(user)
    JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, Rails.application.credentials.devise_jwt_secret_key)
  end
end

