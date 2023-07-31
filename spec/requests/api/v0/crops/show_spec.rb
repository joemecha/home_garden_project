require 'rails_helper'

RSpec.describe 'Crop Show Endpoint', type: :request do
  let(:crops_show_path) { "/api/v0/locations/#{location.id}/crops/#{crop.id}?api_key=#{api_key}" }
  let(:user) { create(:user) }
  let(:api_key) { user.api_key }
  let(:garden) { build(:garden, user:) }
  let(:location) { create(:location, garden:) }
  let(:crop) { create(:crop, location:) }
  let(:user_2) { build(:user) }
  let(:garden_2) { create(:garden, user: user_2) }
  let(:location_2) { create(:location, garden: garden_2) }
  let(:crop_2) { create(:crop, location: location_2) }

  describe 'Happy Path' do

    it 'Returns a specific crop in the database' do  
      get crops_show_path
      crop_details = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(crop_details[:data]).to be_a(Hash)
      expect(crop_details[:data][:id].to_i).to eq(crop.id)
      expect(crop_details[:data][:attributes]).to have_key(:name)
      expect(crop_details[:data][:attributes]).to have_key(:days_to_maturity)
      expect(crop_details[:data][:attributes][:name]).to_not eq(crop_2.name)
      expect(crop_details[:data][:attributes][:date_planted]).to_not eq(crop_2.date_planted)
    end
  end

  describe 'Sad Path' do
    it 'Returns an error if crop not found' do
      get "/api/v0/locations/#{location.id}/crops/10000?api_key=#{api_key}"

      crop_details = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(crop_details[:error]).to be_a(String)
      expect(crop_details[:error]).to eq('Cannot find crop with ID 10000')
    end

    it 'Returns an error message if requesting a crop that does not belong to the current user' do
      get "/api/v0/locations/#{location_2.id}/crops/#{crop_2.id}?api_key=#{api_key}"
      crop_details = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      expect(crop_details[:error]).to be_a(String)
      expect(crop_details[:error]).to eq('You are not authorized to perform this action.')
    end
  end
end
