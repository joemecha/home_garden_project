class AddLocationReferenceToCrops < ActiveRecord::Migration[7.0]
  def change
    add_reference(:crops, :location)
  end
end
