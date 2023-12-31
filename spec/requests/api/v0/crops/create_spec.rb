require 'rails_helper'

RSpec.describe 'Crops Create Endpoint', type: :request do
  let(:user) { create(:user) }
  let(:token) do
    post '/login', params: { user: { email: user.email, password: user.password } }
    JSON.parse(response.body)['token']
  end
  let(:garden) { create(:garden, user:) }
  let(:location) { create(:location, garden:) }

  before do
    # Include the JWT token in the request headers for all examples
    headers = { 'Authorization' => "Bearer #{token}" }
    @headers_with_token = headers
  end

  describe 'POST /api/v0/locations/:id/crops' do
    context 'Happy Path' do
      it 'creates a new crop for a location' do
        headers = {"Content-Type": "application/json"}

        request_body = { 
          crop: { 
            name: 'Radish',
            variety: 'Japanese Kabu',
            days_to_maturity: 40,
            date_planted: 20.days.ago,
            active: true,
            location_id: location.id
          } 
        }.to_json

        post "/api/v0/locations/#{location.id}/crops", headers:, params: request_body

        new_crop = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(201)

        expected_response = {
          data: {
            attributes: { 
              name: 'Radish',
              variety: 'Japanese Kabu',
              date_planted: 20.days.ago.strftime('%Y-%m-%d'),
              days_to_maturity: 40,
              days_remaining_until_harvest: 20,
              active: true,
            },
            id: Crop.last.id.to_s,
            type: 'crops',
          }
        }

        expect(new_crop).to eq(expected_response)
      end
    end

    context 'Sad Path' do
      it 'returns an error if name is blank' do
        crop_params = { crop: { name: '', variety: 'Kabu', days_to_maturity: 40, date_planted: '2023-05-30', active: true, location_id: location.id } }

        post "/api/v0/locations/#{location.id}/crops", params: crop_params

        expect(response).to have_http_status(:bad_request)
        expect(response.body).to eq({ errors: ["Name can't be blank"] }.to_json)
      end
    end
  end
end
