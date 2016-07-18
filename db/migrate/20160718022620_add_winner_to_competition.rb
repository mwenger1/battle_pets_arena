class AddWinnerToCompetition < ActiveRecord::Migration[5.0]
  def change
    add_column :competitions, :winner, :integer
  end
end
