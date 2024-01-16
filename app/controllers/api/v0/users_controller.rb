class Api::V0::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def create
    if !params[:password].present? || !params[:password_confirmation].present? || !params[:email].present?
      render json: { error: [{status: "422", detail: 'Email, password, and password confirmation are required.' }] }, status: :unprocessable_entity
    elsif params[:password] == params[:password_confirmation]
      loop do 
        params[:api_key] = SecureRandom.hex(16)
        break unless User.exists?(api_key: params[:api_key])
      end
      user = User.new(user_params)
      if user.save
        render json: {
        data: {
          type: 'users',
          id: user.id.to_s,
          attributes: {
            email: user.email,
            api_key: user.api_key
          }
        }
      }, status: :created
      else
        render json: { error: [{status: "422", detail: 'Email already exists.' }] }, status: :unprocessable_entity
      end
    else params[:password] != params[:password_confirmation]
      render json: { error: [{status: "422", detail: 'Password and password confirmation do not match.' }] }, status: :unprocessable_entity
    end
  end
  
  private
  def user_params
    params.permit(:email, :password, :api_key)
  end

  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
      .serialize_json, status: :not_found
  end
end