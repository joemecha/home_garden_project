require 'rails_helper'

RSpec.describe User do
  describe 'relationships' do
    it { should have_many :gardens }
  end

  describe 'validations' do
    it { should validate_presence_of :email_address }
    it do
      should validate_uniqueness_of(:email_address).
        case_insensitive
    end
  end

  describe 'user attributes' do
    it 'user has an email address and api key after creation' do
      @user = User.create(email_address: 'something@example.com', password: 'password19', password_confirmation: 'password19')
      @user.api_key = SecureRandom.hex
      
      expect(@user.email_address).to eq('something@example.com')
      expect(@user.api_key.present?).to eq(true)
    end
  end
end
