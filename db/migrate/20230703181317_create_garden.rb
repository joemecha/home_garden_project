class CreateGarden < ActiveRecord::Migration[7.0]
  def change
    create_table :gardens do |t|
      t.string :name, null: false
      t.float :size

      t.timestamps
    end
  end
end
