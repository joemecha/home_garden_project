require "rails_helper"

describe Location, type: :model do
  describe "relationships" do
    it { should belong_to :garden }
    it { should have_many :location_crops }
    it { should have_many(:crops).through(:location_crops) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
  end
end
