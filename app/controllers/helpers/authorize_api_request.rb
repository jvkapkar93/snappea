class AuthorizeApiRequest
    #prepend SimpleCommand
  
    def initialize(headers = {})
      @headers = headers
    end
  
    def authenticate_user
      user
    end
  
    private
  
    attr_reader :headers
  
    def user
      if headers['Authorization'].present?
        token =  headers['Authorization']
        @user ||= User.find_by_auth_token(token)
      else 
        return nil
      end
    end  
  end