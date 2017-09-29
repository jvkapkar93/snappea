require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  subject { described_class.new(description: "desc", rating: 2.4, address: "address",name: "name") } 
  describe "Validations" do 
  it "is valid with all attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without attributes" do   
    expect(Restaurant.new).to_not be_valid
  end

  it "is not valid without a name" do
    subject.name = nil   
    expect(subject).to_not be_valid
  end

  it "is not valid without a description" do
    subject.description = nil 
    expect(subject).to_not be_valid
  end

  it "is not valid without a rating" do
    subject.rating = nil
    expect(subject).to_not be_valid
  end

  it "is not valid having rating of type string" do
    subject.rating = "4.0"
    expect(subject).to be_valid
  end

  it "is not valid without a address" do
    subject.address = nil    
    expect(subject).to_not be_valid
  end

  it { should validate_presence_of(:name) }

end
describe "Associations" do
  it { should have_many(:menus) }
end
end
