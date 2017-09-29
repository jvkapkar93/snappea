require_relative 'helpers/authenticate_user'
class AuthenticationController < ApplicationController
skip_before_action :authenticate_request

def login
  token = AuthenticateUser.new(params[:username], params[:password]).login#(params[:username], params[:password])
  if !token.blank? && !token.nil?
    user = User.find_by_username(params[:username])
    render json: {success: true, msg:"login successful", auth_token: token }, status:200
  else
    render json: { error: 'invalid credentials' }, status:401
  end
end
end