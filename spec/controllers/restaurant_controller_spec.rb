require 'rails_helper'
require_relative '../../app/controllers/api/restaurant_controller'
RSpec.describe Api::RestaurantController, type: :controller do

    describe ".create" do
        let(:restaurant) { Restaurant.create(:name => 'Resto 1', :description => 'desc1',
        :rating => 5.5, :address =>'Address') }
        
        it "creats new restaurant" do
            expect(restaurant.errors).to be_empty
        end
        it "creats new restaurant" do
            expect(Restaurant.create(:name => 'Resto 1').errors).to_not be_empty
        end
    end
end
