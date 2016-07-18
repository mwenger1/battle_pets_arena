require "rails_helper"

RSpec.describe Competition, type: :model do
  describe "validations" do
    it do
      is_expected.to validate_numericality_of(:challenger).only_integer
    end

    it do
      is_expected.to validate_numericality_of(:challenged).only_integer
    end
  end

  describe "#before_create" do
    it "randomly assigns one of the default competition_types" do
      5.times { create(:competition, competition_type: nil) }

      competition_types = Competition.all.pluck(:competition_type)
      expect(competition_types.uniq.length).to be > 1
      expect(competition_types - Competition::COMPETITION_TYPES).to eq []
    end
  end
end
