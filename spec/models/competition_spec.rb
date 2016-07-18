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

  describe "#after_create" do
    it "starts a JudgeCompetitionJob" do
      allow(JudgeCompetitionJob).to receive(:perform_now)

      competition = create(:competition)

      expect(JudgeCompetitionJob).to have_received(:perform_now).
        with(competition)
    end
  end
end
