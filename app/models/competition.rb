class Competition < ApplicationRecord
  before_create :set_competition_type

  private

  def set_competition_type
    send("competition_type=", ["Strength"])
  end
end
