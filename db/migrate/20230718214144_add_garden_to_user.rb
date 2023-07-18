class AddGardenToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :gardens, :user, foreign_key: true
  end
end
