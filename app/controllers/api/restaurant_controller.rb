module Api
    class RestaurantController < ApplicationController
        def initialize
        end

        def index
            restaurants = Restaurant.paginate(:page => params[:page], :per_page => 5)
            render json: {status: 'success', message: 'All restos', data: restaurants}, status:200
        end
        def show
            begin
            restaurant = Restaurant.find(params[:id])
            render json: {status: 'success', message: 'All restos', data: restaurant}, status:200
            rescue Exception => e
                render json: {status: 'errr', message: 'no record found ', data: e}, status:200
            end
        end
        def create
            resto = Restaurant.new(resto_params)
            if resto.save
                render json: {status: 'success', message: 'saved restos', data:resto}, status:200
            else
                render json: {status: 'error', message: 'failed to store resto', data:resto.errors}, status: :unprocessable_entity
            end
        end
        def destroy
            begin
            restaurant = Restaurant.find(params[:id])            
            restaurant.destroy
            render json: {status: 'success', message: 'saved restos', data:restaurant}, status:200 
            rescue Exception =>e
                render json: {status: 'err', message: 'failed to delete resto', data:e}, status:200
            end 
        end
        def update
            resto = Restaurant.find(params[:id])
            if resto.update_attributes(resto_params)
                render json: {status: 'success', message: 'updated restos', data:resto}, status:200
            else
                render json: {status: 'error', message: 'failed to update resto', data:resto.errors}, status: :unprocessable_entity
            end
        end
        def resto_params
            params.permit(:name, :rating, :address, :description)
        end

        def parse_request
            @reqJSON =JSON.parse(request.body.read)
        end
        def authenticate_user_from_token!
            if @reqJSON['token']
                render json:{success: 'success',msg: 'token is available', data: @reqJSON}, status:200
            else
                render json:{success: 'failed',msg: 'token is not available', data: @reqJSON}, status:401
            end
        end
        private def find_project
          @project = Restaurant.find_by_name(params[:name])
          render json:{nothing: true}, status: :not_found unless @project.present?
        end
      
    end
end