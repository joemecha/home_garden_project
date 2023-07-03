class CreateCrop < ActiveRecord::Migration[7.0]
  def change
    create_table :crops do |t|
      t.string :name, null: false
      t.string :variety
      t.integer :days_to_maturity, null: false
      t.date :date_planted, null: false
      t.boolean :active
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
