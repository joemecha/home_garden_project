class CreateLocationCrops < ActiveRecord::Migration[7.0]
  def change
    create_table :location_crops do |t|
      t.references :location, null: false, foreign_key: true
      t.references :crop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
