class JudgeCompetitionJob < ApplicationJob
  queue_as :default

  def perform(competition)
    challenger = BattlePetGateway.fetch_battle_pet(competition.challenger)
    challenged = BattlePetGateway.fetch_battle_pet(competition.challenged)

    winning_combatant = [challenger, challenged].max do |combatant|
      if combatant
        combatant.send(competition.competition_type)
      else
        0
      end
    end

    competition.update(winner: winning_combatant.id)
  end
end
