require 'rails_helper'

RSpec.describe 'Garden Show Endpoint', type: :request do
  let(:gardens_show_path) { "/api/v0/gardens/#{garden.id}?api_key=#{api_key}" }
  let(:user) { create(:user) }
  let(:api_key) { user.api_key }
  let(:garden) { create(:garden, user:) }
  let(:user_2) { build(:user) }
  let(:garden_2) { create(:garden, user: user_2) }

  describe 'Happy Path' do

    it 'Returns a specific garden in the database' do  
      get gardens_show_path
      garden_details = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(garden_details[:data]).to be_a(Hash)
      expect(garden_details[:data][:id].to_i).to eq(garden.id)
      expect(garden_details[:data][:attributes]).to have_key(:name)
      expect(garden_details[:data][:attributes]).to have_key(:size)
      expect(garden_details[:data][:attributes][:name]).to_not eq(garden_2.name)
      expect(garden_details[:data][:attributes][:owner]).to_not eq(garden_2.size)
    end
  end

  describe 'Sad Path' do
    it 'Returns an error if garden not found' do
      get "/api/v0/gardens/1000?api_key=#{api_key}"

      garden_details = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(garden_details[:error]).to be_a(String)
      expect(garden_details[:error]).to eq('Cannot find garden with ID 1000')
    end

    it 'Returns an error message if requesting a garden that does not belong to the current user' do
      get "/api/v0/gardens/#{garden_2.id}?api_key=#{api_key}"
      garden_details = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect(garden_details[:error]).to be_a(String)
      expect(garden_details[:error]).to eq("Cannot find garden with ID #{garden_2.id}")
    end
  end
end
