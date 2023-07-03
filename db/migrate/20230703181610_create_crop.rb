class CreateCrop < ActiveRecord::Migration[7.0]
  def change
    create_table :crops do |t|
      t.string :name, null: false
      t.string :variety
      t.integer :daysToMaturity, null: false
      t.date :datePlanted, null: false
      t.boolean :active
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
