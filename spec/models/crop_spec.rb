require 'rails_helper'

describe Crop, type: :model do
  describe 'relationships' do
    it { should belong_to :location }
    it { should have_many :notes }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :days_to_maturity }
    it { should validate_presence_of :date_planted }
  end

  describe "#days_remaining_until_harvest" do
    before do
      # Freeze time to a specific date to make the tests timezone-independent
      travel_to Time.zone.local(2023, 8, 1, 12, 00)
    end

    after do
      travel_back
    end
    context "when there are remaining days until harvest" do
      let(:location) { build(:location) }
      let(:crop) { create(:crop, days_to_maturity: 20, date_planted: Date.today - 10, location:) }
      
      it "returns the correct number of days remaining" do  
        expect(crop.days_remaining_until_harvest).to eq(10)
      end
    end
    
    context "when the crop has already matured" do
      let(:location) { build(:location) }
      let(:crop) { create(:crop, days_to_maturity: 20, date_planted: Date.today - 25, location:) }
      
      it "returns 0" do  
        # The date of maturity has passed so returns 0
        expect(crop.days_remaining_until_harvest).to eq(0)
      end
    end
    
    context "when date_planted is in the future" do
      let(:location) { build(:location) }
      let(:crop) { create(:crop, days_to_maturity: 20, date_planted: Date.today + 5, location:) }

      it "returns days_to_maturity" do
        # The expected result should be 25
        expect(crop.days_remaining_until_harvest).to eq(25)
      end
    end
  end
end
