require "rails_helper"

RSpec.describe BattlePetGateway, type: :service do
  describe "fetch_battle_pet" do
    it "retrieves BattlePet attributes from BattlePets Management service" do
      allow(RestClient).to receive(:get)
      allow(BattlePet).to receive(:new)
      id = 1

      BattlePetGateway.fetch_battle_pet(id)

      expect(RestClient).to have_received(:get).
        with("#{BattlePetGateway::ENDPOINT}/#{id}")
    end

    it "returns a BattlePet object" do
      battle_pet_name = "Pikachu"
      response_json = {
        "id": 4,
        "name": battle_pet_name,
        "strength": 13,
        "agility": 1,
        "wit": 3,
        "senses": 3,
        "created_at": "2016-07-17T23:03:35.511Z",
        "updated_at": "2016-07-17T23:03:35.511Z",
        "trainer_id": 3
      }

      allow(RestClient).to receive(:get).and_return(response_json)
      id = 1

      battle_pet = BattlePetGateway.fetch_battle_pet(id)

      expect(battle_pet.name).to eq battle_pet_name
    end
  end
end
