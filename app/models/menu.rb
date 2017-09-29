class Menu < ApplicationRecord
  belongs_to :restaurant
  has_many :tags
  validates :name, presence:true
  validates :restaurant_id, presence:true
end
