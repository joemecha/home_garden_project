require 'rails_helper'

RSpec.describe 'Gardens Show Endpoint', type: :request do
  let(:gardens_show_path) { "/api/v0/gardens/#{garden.id}" }
  let(:user) { create(:user) }
  let(:token) do
    post '/login', params: { user: { email: user.email, password: user.password } }
    JSON.parse(response.body)['token']
  end
  let(:garden) { create(:garden, user:) }
  let(:user_2) { build(:user) }
  let(:garden_2) { create(:garden, user: user_2) }

  before do
    # Include the JWT token in the request headers for all examples
    headers = { 'Authorization' => "Bearer #{token}" }
    @headers_with_token = headers
  end

  describe 'GET /api/v0/garden/:id' do
    context 'Happy Path' do
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
        expect(garden_details[:data][:attributes][:size]).to_not eq(garden_2.size)
      end
    end

    context 'Sad Path' do
      it 'Returns an error if garden not found' do
        get "/api/v0/gardens/1000"

        garden_details = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(404)
        expect(garden_details[:error]).to be_a(String)
        expect(garden_details[:error]).to eq('Cannot find garden with ID 1000')
      end

      it 'Returns an error message if requesting a garden that does not belong to the current user' do
        post '/login', params: { user: { email: user.email, password: user.password } }

        get "/api/v0/gardens/#{garden_2.id}"

        garden_details = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        expect(garden_details[:error]).to be_a(String)
        expect(garden_details[:error]).to eq("Cannot find garden with ID #{garden_2.id}")
      end
    end
  end
end
