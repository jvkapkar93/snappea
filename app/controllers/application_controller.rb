require_relative 'helpers/authorize_api_request'
class ApplicationController < ActionController::API
    before_action :authenticate_request
    attr_reader :current_user
  
    private 
    def authenticate_request
      @current_user = AuthorizeApiRequest.new(request.headers).authenticate_user
      render json: { success: false, msg: 'failedd to authenticate user' , data: "token is not valid"}, status: 401 unless @current_user
    end

end
