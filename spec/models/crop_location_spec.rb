require "rails_helper"

describe LocationCrop, type: :model do
  describe "relationships" do
    it { should belong_to :crop}
    it { should belong_to :location}
  end
end
