require 'rails_helper'

RSpec.describe JudgeCompetitionJob do
  before do
    treat_as_integration_test_and_stub_rest_client
  end

  describe "#perform" do
    it "gets attributes for challenger and challenged" do
      competition = create(:competition)
      battle_pet = build_battle_pet(strength: 4, id: 2)
      allow(BattlePetGateway).to receive(:fetch_battle_pet).and_return(battle_pet)

      JudgeCompetitionJob.new.perform(competition)

      expect(BattlePetGateway).to have_received(:fetch_battle_pet).
        with(competition.challenger)
      expect(BattlePetGateway).to have_received(:fetch_battle_pet).
        with(competition.challenged)
    end

    it "uses competition type to determine winner" do
      competition = create(:competition)
      competition.update(competition_type: "strength")
      challenger_id = 1
      challenger = build_battle_pet(strength: 15, id: challenger_id)
      challenged = build_battle_pet(strength: 14, id: 2)
      allow(BattlePetGateway).to receive(:fetch_battle_pet).
        with(competition.challenger).and_return(challenger)
      allow(BattlePetGateway).to receive(:fetch_battle_pet).
        with(competition.challenged).and_return(challenged)

      JudgeCompetitionJob.new.perform(competition)

      expect(competition.winner).to eq challenger_id
    end

    context "there is a tie score" do
      it "awards victory to the challenger b/c they are aggressive" do
        competition = create(:competition)
        competition.update(competition_type: "strength")
        challenger_id = 1
        challenger = build_battle_pet(strength: 15, id: challenger_id)
        challenged = build_battle_pet(strength: 15, id: 2)
        allow(BattlePetGateway).to receive(:fetch_battle_pet).
          with(competition.challenger).and_return(challenger)
        allow(BattlePetGateway).to receive(:fetch_battle_pet).
          with(competition.challenged).and_return(challenged)

        JudgeCompetitionJob.new.perform(competition)

        expect(competition.winner).to eq challenger_id
      end
    end
  end

  def build_battle_pet(strength:, id:)
    BattlePet.new(id: id, strength: strength, agility: 1, senses: 1, wit: 1, name: "BattleBot")
  end

  def treat_as_integration_test_and_stub_rest_client
    allow(RestClient).to receive(:get).and_return(valid_response.to_json)
  end

  def valid_response
    {
      "id": 100,
      "name": "Pikachu",
      "strength": 13,
      "agility": 1,
      "wit": 3,
      "senses": 3,
      "created_at": "2016-07-17T23:03:35.511Z",
      "updated_at": "2016-07-17T23:03:35.511Z",
      "trainer_id": 3
    }
  end
end
