require "rails_helper"

describe Crop, type: :model do
  describe "relationships" do
    it { should have_many :location_crops }
    it { should have_many(:locations).through(:location_crops) }
    it { should have_many :notes }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :days_to_maturity }
    it { should validate_presence_of :date_planted }
  end
end
