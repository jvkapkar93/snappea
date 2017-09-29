module Api
        class TagController < ApplicationController
            def index
               begin
                @menu = Menu.find_by({"restaurant_id": params[:restaurant_id],"id": params[:menu_id]})
                if @menu.nil? && @menu.blank?
                 raise 'Invalid criteria for adding the tag'
                end
                tag = Tag.where("menu_id" => params[:menu_id])
                if !tag.blank?
                render json:{success:true, msg:"found the list of tags for menu" ,data:tag }, status:200
                else
                    raise 'No data found for given criteria'
                end
               rescue Exception =>e
                render json:{success:false, msg:"failed to get tags list",data:e }, status:404
               end
            end
            
    
            def show
                begin
                    @menu = Menu.find_by({"restaurant_id": params[:restaurant_id],"id": params[:menu_id]})
                    if @menu.nil? && @menu.blank?
                     raise 'Invalid criteria for adding the tag'
                    end
                    tag = Tag.where({"menu_id": params[:menu_id], "id":params[:id]})
                if !tag.blank?
                    render json:{success:true, msg:"found the list of tags for menu" ,data:tag }, status:200
                else
                    raise 'No data found for given criteria'
                end
                rescue Exception => e
                    render json:{success:false, msg:"failse to get data",data:e }, status:404
                end
            end
    
            def create
                begin
                    @menu = Menu.find_by({"restaurant_id": params[:restaurant_id],"id": params[:menu_id]})
                   if @menu.nil? && @menu.blank?
                    raise 'Invalid criteria for adding the tag'
                   end
                    @tag = @menu.tags.new(request_params)
                    if @tag.save
                        render json:{success:true, msg:"tag added successfully", data:@tag },status:200
                    else 
                        render json:{success:false, msg:"failed to create", data:@tag },status:500
                    end
                rescue Exception =>e
                    render json:{success:false, msg:"failed to create", data:e },status:404
                end
            end
    
            def destroy 
                begin
                    menu = Menu.find_by({"restaurant_id": params[:restaurant_id],"id": params[:menu_id]})
                    tag = Tag.find_by("menu_id" => params[:menu_id] ,"id" => params[:id] )
                    if !tag.nil? && !tag.blank? && !menu.nil? && !menu.blank?
                        tag.destroy
                        render json:{success:true, msg:"tag deleted successfully", data:tag },status:200
                    else 
                        render json:{success:false, msg:"No tag available to delete for given criteria" },status:500
                    end
                rescue Exception => e
                    render json:{success:false, msg:"failed to delete", data:e },status:404
                end
            end
    
            def update
                begin
                @tag = Tag.where("restaurant_id"=>params[:restaurant_id],"id" => params[:id])           
                if !@tag.blank?
                    @tag.update(request_params)
                    render json:{success:true, msg:"tag updated successfully", data:@tag },status:200
                else
                    render json:{success:false, msg:"failed to update", data:@tag },status:200
                end
                rescue Exception => e
                    render json:{success:false, msg:"failed to update", data:e },status:404
                end
            end
    
            private def request_params
                params.require(:tag).permit(:name, :description, :category, :tag)
            end
        end
end
