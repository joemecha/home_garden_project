require 'rails_helper'

RSpec.describe User do
  describe 'relationships' do
    it { should have_many :gardens }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
  end

  describe 'user attributes' do
    it 'user has an email address and api key after creation' do
      user = User.create(email: 'something@example.com', password: 'password19', name: 'Josh')
      
      expect(user.email).to eq('something@example.com')
      expect(user.name).to eq('Josh')
    end

    it 'sets time zone based on zip code when zip code is present' do
      random_zip_code = Faker::Address.zip_code[0..4]

      stub_request(:get, /https:\/\/www.mapquestapi.com\/geocoding\/v1\/address/).to_return(status: 200, body: <<~JSON
        {
          "results": [
            {
              "locations": [
                {
                  "latLng": {
                    "lat": 37.7749,
                    "lng": -122.4194
                  }
                }
              ]
            }
          ]
        }
      JSON
      )

      user = User.create!(email: 'something@example.com', password: 'password19', name: 'Josh', zip_code: random_zip_code)

      expect(user.time_zone).to eq('America/Los_Angeles')
    end

    it 'does not set time zone when zip code is blank' do
      user = User.create(email: 'something@example.com', password: 'password19', name: 'Josh', zip_code: nil)
      
      expect(user.time_zone).to be_nil
    end
  end
end
