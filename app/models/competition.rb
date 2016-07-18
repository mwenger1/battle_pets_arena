class Competition < ApplicationRecord
  COMPETITION_TYPES = %w(strength wit senses agility)
  before_validation :set_competition_type, on: :create
  after_create :judge_competition

  validates :challenger, presence: true, numericality: { only_integer: true }
  validates :challenged, presence: true, numericality: { only_integer: true }
  validates :competition_type, presence: true

  private

  def judge_competition
    JudgeCompetitionJob.perform_now(self)
  end

  def set_competition_type
    send("competition_type=", COMPETITION_TYPES.sample)
  end
end
