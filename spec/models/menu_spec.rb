require 'rails_helper'

RSpec.describe Menu, type: :model do
  subject {described_class.new(description: "desc", restaurant_id: 1, category: "address",name: "name")}
  it "is valid with all attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without attributes" do   
    expect(Menu.new).to_not be_valid
  end

  it "is not valid without a name" do
    subject.name = nil   
    expect(subject).to_not be_valid
  end

  it "is valid without a description" do
    subject.description = nil 
    expect(subject).to be_valid
  end

  it "is not valid without a restaurant_id" do
    subject.restaurant_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid having rating of type string" do
    subject.restaurant_id = "4.0"
    expect(subject).to be_valid
  end
  it {should validate_presence_of(:restaurant_id)}  
  it {should validate_presence_of(:name)}  
  
  describe "Associations" do
  it { should belong_to(:restaurant) }
  it { should have_many(:tags) }
  end
end
