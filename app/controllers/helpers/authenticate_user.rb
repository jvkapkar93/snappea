require 'securerandom'
class AuthenticateUser
  
    def initialize(username, password)
      @username = username
      @password = password
    end
  
    def login
      if user             
      token = SecureRandom.uuid
        if !token.blank? && !token.nil?
          @user = User.find_by("username" => username)
          @user.update_attributes(:auth_token => token)
          return token
        end
      else 
        return nil
      end
    end
  
    private  
    attr_accessor :username, :password
  
    def user
      @user = User.find_by("username" => username, "password"=> password)
      if !@user.blank? && !@user.nil?
        return true
      else return nil
      end
    end
  end