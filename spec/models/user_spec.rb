require 'rails_helper'

RSpec.describe User do
  describe 'relationships' do
    it { should have_many :gardens }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :zip_code }
  end
end
