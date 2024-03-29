# frozen_string_literal: true

class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.string :name
      t.references :draw, null: false, foreign_key: true
      t.references :team1
      t.references :team2

      t.timestamps
    end
    add_foreign_key :matches, :teams, column: :team1_id, primary_key: :id
    add_foreign_key :matches, :teams, column: :team2_id, primary_key: :id
  end
end
