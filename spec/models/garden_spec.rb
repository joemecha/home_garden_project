require "rails_helper"

describe Garden, type: :model do
  describe "relationships" do
    it { should belong_to :user}
    it { should have_many :locations}
  end

  describe "validations" do
    it {should validate_presence_of :name}
  end
end
