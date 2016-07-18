class JudgeCompetitionJob < ApplicationJob
  queue_as :default

  def perform(competition)
    challenger = BattlePetGateway.fetch_battle_pet(competition.challenger)
    challenged = BattlePetGateway.fetch_battle_pet(competition.challenged)

    winner = calculate_winner(
      challenger: challenger,
      challenged: challenged,
      type: competition.competition_type
    )

    if winner.present?
      competition.update(winner: winner.id)
    end
  end

  def calculate_winner(challenger:, challenged:, type:)
    challenger_score = challenger.send(type)
    challenged_score = challenged.send(type)

    if challenger_score > challenged_score
      challenger
    elsif challenger_score < challenged_score
      challenged
    elsif challenger_score == challenged_score
      challenger
    end
  end
end
