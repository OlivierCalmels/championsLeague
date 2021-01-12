class CreateDraws < ActiveRecord::Migration[6.0]
  def change
    create_table :draws do |t|
      t.references :tournament, null: false, foreign_key: true

      t.timestamps
    end
  end
end
