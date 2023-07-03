require "rails_helper"

describe Location, type: :model do
  describe "relationships" do
    it { should belong_to :garden}
    it { should have_many :crops}
  end

  describe "validations" do
    it {should validate_presence_of :name}
  end
end
