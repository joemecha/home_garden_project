class CreateLocation < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.float :size
      t.boolean :irrigated
      t.references :garden, null: false, foreign_key: true

      t.timestamps
    end
  end
end
