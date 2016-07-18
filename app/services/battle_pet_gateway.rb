class BattlePetGateway
  ENDPOINT = "http://localhost:7000/v1/battle_pets"

  def self.fetch_battle_pet(id)
    response = JSON.parse(
      RestClient.get [ENDPOINT, id].join("/")
    )

    BattlePet.new(response.symbolize_keys)
  end
end
