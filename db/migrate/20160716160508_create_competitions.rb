class CreateCompetitions < ActiveRecord::Migration[5.0]
  def change
    create_table :competitions do |t|
      t.string :competition_type, null: false, array: true
      t.integer :challenger, null: false
      t.integer :challenged, null: false

      t.timestamps
    end
  end
end
