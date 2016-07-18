class BattlePet
  attr_reader :id, :name, :strength, :agility, :wit, :senses

  def initialize(id:, name:, strength:, agility:, wit:, senses:, **)
    @id = id
    @name = name
    @strength = strength
    @agility = agility
    @wit = wit
    @senses = senses
  end
end
