class RemoveLocationFromCrops < ActiveRecord::Migration[7.0]
  def change
    remove_reference :crops, :location, foreign_key: true, index: false
  end
end
