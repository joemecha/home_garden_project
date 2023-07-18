class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email_address
      t.string :password_digest
      t.string :api_key

      t.timestamps
    end
  end
end
