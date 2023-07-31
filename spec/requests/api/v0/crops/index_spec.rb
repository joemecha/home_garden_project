require 'rails_helper'

RSpec.describe 'Crop Index Endpoint', type: :request do
  let(:crops_index_path) { "/api/v0/locations/#{location.id}/crops?api_key=#{user.api_key}" }
  let(:user) { create(:user) }
  let(:api_key) { user.api_key }
  let(:garden) { build(:garden, user:) }
  let(:location) { create(:location, garden:) }

  describe 'Happy Path' do
    it 'Returns a list of crops in the database' do
      2.times do
        create(:crop, location:)
      end
      
      get crops_index_path
      crop_list = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(crop_list[:data]).to be_an(Array)
      expect(crop_list[:data].count).to eq(2)
      expect(crop_list[:data].first[:attributes]).to have_key(:name)
      expect(crop_list[:data].first[:attributes]).to have_key(:days_to_maturity)
      expect(crop_list[:data].first[:attributes]).to have_key(:active)
    end

    it 'Returns a message if no crops in the database' do
      get crops_index_path
      crop_list = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(crop_list[:message]).to be_a(String)
      expect(crop_list[:message]).to eq('You currently have no crops in this location.')
    end
  end

  describe 'Sad Path' do
    it 'Returns an error message if no api key' do
      get "/api/v0/locations/#{location.id}/crops"
      crop_list = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      expect(crop_list[:message]).to be_a(String)
      expect(crop_list[:message]).to eq('Invalid or missing API key')
    end

    it 'Returns an error message if incorrect api key' do
      get "/api/v0/locations/#{location.id}/crops?api_key=0000"
      crop_list = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      expect(crop_list[:message]).to be_a(String)
      expect(crop_list[:message]).to eq('Invalid or missing API key')
    end
  end
end
