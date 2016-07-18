class Competition < ApplicationRecord
  COMPETITION_TYPES = %w(strength wit senses agility)
  before_validation :set_competition_type, on: :create

  validates :challenger, presence: true, numericality: { only_integer: true }
  validates :challenged, presence: true, numericality: { only_integer: true }
  validates :competition_type, presence: true

  private

  def set_competition_type
    send("competition_type=", COMPETITION_TYPES.sample)
  end
end
