require_relative 'restaurant_controller'
module Api
    class MenuController < ApplicationController
        def index
           begin
           # resto = Restaurant.find(params[:restaurant_id])
            @menu = Menu.where("restaurant_id" => params[:restaurant_id])
            if !@menu.blank?
                newMenu = Array.new
                @menu.each do |menu|
                    menuHash = Hash.new
                    menuHash["id"] =menu.id
                    menuHash["restaurant_id"] =menu.restaurant_id
                    menuHash["name"] =menu.name
                    menuHash["description"]=menu.description
                    menuHash["category"]=menu.category
                    tags = Tag.where({"menu_id": menu.id}) 
                    if !tags.nil? && !tags.blank?
                        tagList = Array.new
                        tags.each do |tag|
                            tagList << tag.name
                        end
                        menuHash["tags"] = tagList
                    else
                        
                        menuHash["tags"]=Array.new
                    end
                    newMenu << menuHash
                end
                #tags = Tag.find_by({"menu_id": @menu['id']})
                #menu['tags'] = tags
            render json:{success:true, msg:"found the list of menus for resto" ,data:newMenu }, status:200
            else
                raise 'No data found for given criteria'
            end
           rescue Exception =>e
            render json:{success:false, msg:"failed to get menu list",data:e }, status:404
           end
        end
        

        def show
            begin
                menu = Menu.find_by({"restaurant_id": params[:restaurant_id], "id":params[:id]})
            if !menu.blank?
                newMenu = Array.new
                menuHash = Hash.new
                menuHash["id"] =menu.id
                menuHash["restaurant_id"] =menu.restaurant_id
                menuHash["name"] =menu.name
                menuHash["description"]=menu.description
                menuHash["category"]=menu.category
                tags = Tag.where({"menu_id": menu.id}) 
                if !tags.nil? && !tags.blank?
                    tagList = Array.new
                    tags.each do |tag|
                        tagList << tag.name
                    end
                    menuHash["tags"] = tagList
                else
                    
                    menuHash["tags"]=Array.new
                end
                newMenu << menuHash           
            
                render json:{success:true, msg:"found the list of menus for resto" ,data:newMenu }, status:200
            else
                raise 'No data found for given criteria'
            end
            rescue Exception => e
                render json:{success:false, msg:"failse to get data",data:e }, status:404
            end
        end

        def create
            begin
                @resto = Restaurant.find(params[:restaurant_id])
                @menu = @resto.menus.new(request_params)
                if @menu.save
                    render json:{success:true, msg:"menu added successfully", data:@menu },status:200
                else 
                    render json:{success:false, msg:"failed to create", data:@menu },status:500
                end
            rescue Exception =>e
                render json:{success:false, msg:"failed to create", data:e },status:404
            end
        end

        def destroy 
            begin
                menu = Menu.find_by("restaurant_id" => params[:restaurant_id] ,"id" => params[:id] )
                if !menu.blank?
                    menu.destroy
                    render json:{success:true, msg:"menu deleted successfully", data:menu },status:200
                else 
                    render json:{success:false, msg:"No Menu available to delete for given criteria" },status:500
                end
            rescue Exception => e
                render json:{success:false, msg:"failed to delete", data:e },status:404
            end
        end

        def update
            begin
            @menu = Menu.where("restaurant_id"=>params[:restaurant_id],"id" => params[:id])           
            if !@menu.blank?
                @menu.update(request_params)
                render json:{success:true, msg:"menu updated successfully", data:@menu },status:200
            else
                render json:{success:false, msg:"failed to update", data:@menu },status:200
            end
            rescue Exception => e
                render json:{success:false, msg:"failed to update", data:e },status:404
            end
        end

        private def request_params
            params.require(:menu).permit(:name, :description, :category, :tag)
        end
    end
end