
module Api
    class UserController < ApplicationController
    def index
        userlist = User.all
        render json:{success: true, msg: "user list", data: userlist },status:200
    end

    def show 
        begin
        user = User.find(params[:id])  
        if !user.blank? && !user.nil?
        render json:{success: true, msg: "user list", data: user },status:200
        else
            raise "no data found for user id = #{ params[:id] }"
        end
        rescue Exception => e
            render json:{success: false, msg: "failed to get user detail", data: e },status:404
        end
    end

    def create     
        begin
        user = User.new(request_params)
        if user.save
            render json: {success: true, message: 'user added successfuly', data: user}, status:200
        else
            render json: {success: false, message: 'failed to add user', data:user.errors}, status: :unprocessable_entity
        end
        rescue Exception =>e
            render json: {success: false, message: 'failed to add user', data:e}, status:500
        end
    end

    def destroy
        begin
            user = User.find(params[:id])
            if user.destroy
                render json: {success: true, message: 'user deleted successfuly', data: user}, status:200
            else
                raise 'server Error! Cant delete user'
            end
         rescue Exception =>e
             render json: {success: false, message: 'failed to delete user', data:e}, status:500
         end
    end

    def update
        begin
            user = User.find(params[:id])
            if user.update(request_params)
                render json: {success: true, message: 'user added successfuly', data: user}, status:200
            else
                render json: {success: false, message: 'failed to add user', data:user.errors}, status:422 # :unprocessable_entity
            end
         rescue Exception =>e
             render json: {success: false, message: 'failed to add user', data:e}, status:500
         end
    end

    private def request_params
        params.require(:user).permit(:username, :password, :address, :mobile, :email)
    end

end
end