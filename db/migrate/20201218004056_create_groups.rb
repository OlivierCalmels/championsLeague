class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.references :tournament, null: false, foreign_key: true
      t.references :first_team, null: false
      t.references :second_team, null: false
      t.integer :number

      t.timestamps
    end
    add_foreign_key :groups, :teams, column: :first_team_id
    add_foreign_key :groups, :teams, column: :second_team_id
  end
end
