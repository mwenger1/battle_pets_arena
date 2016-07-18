class BattlePetGateway
  ENDPOINT = "http://localhost:7000/battle_pets"

  def self.fetch_battle_pet(id)
    BattlePet.new(RestClient.get [ENDPOINT, id].join("/"))
  end
end
