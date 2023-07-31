class DropLocationCropsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :location_crops
  end
end
