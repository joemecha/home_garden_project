require 'rails_helper'

RSpec.describe User do
  describe 'relationships' do
    it { should have_many :gardens }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it do
      should validate_uniqueness_of(:email).
        case_insensitive
    end
  end

  describe 'user attributes' do
    it 'user has an email address and api key after creation' do
      user = User.create(email: 'something@example.com', password: 'password19', name: 'Josh')
      
      expect(user.email).to eq('something@example.com')
      expect(user.name).to eq('Josh')
    end
  end
end
