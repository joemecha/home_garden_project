require "rails_helper"

describe Note, type: :model do
  describe "relationships" do
    it { should belong_to :crop}
  end

  describe "validations" do
    it {should validate_presence_of :body}
  end
end
