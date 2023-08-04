require 'rails_helper'

RSpec.describe CropSerializer do
  subject { CropSerializer.new(crop) }

  let(:location) { build(:location) }
  let(:crop) { create(:crop, days_to_maturity: 20, date_planted: Date.today - 10, location:) }

  before do
    # Freeze time to a specific date to make the tests timezone-independent
    travel_to Time.zone.local(2023, 8, 1, 12, 00)
  end

  after do
    travel_back
  end

  it 'should include the days_remaining_until_harvest attribute' do
    days_remaining = subject.serializable_hash[:data][:attributes][:days_remaining_until_harvest]
    expect(days_remaining).to eq(10)
  end

  it 'should include all other attributes' do
    expect(subject.serializable_hash[:data][:attributes]).to include(
      active: crop.active,
      date_planted: crop.date_planted.to_s,
      days_to_maturity: crop.days_to_maturity,
      name: crop.name,
      variety: crop.variety
    )
  end

  context 'when the crop has already matured' do
    let(:crop) { create(:crop, days_to_maturity: 20, date_planted: Date.today - 25, location:) }

    it 'should have days_remaining_until_harvest as 0' do
      expect(subject.serializable_hash[:data][:attributes][:days_remaining_until_harvest]).to eq(0)
    end
  end

  context 'when date_planted is in the future' do
    let(:crop) { create(:crop, days_to_maturity: 20, date_planted: Date.today + 5, location:) }

    it 'should have days_remaining_until_harvest as days_to_maturity' do
      expect(subject.serializable_hash[:data][:attributes][:days_remaining_until_harvest]).to eq(25)
    end
  end

  context 'when the crop is inactive' do
    let(:crop) { create(:crop, :inactive_crop, location:) }

    it 'should have days_remaining_until_harvest as 0' do
      expect(subject.serializable_hash[:data][:attributes][:days_remaining_until_harvest]).to eq(0)
    end
  end
end
