class AddZipCodeAndTimeZoneToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :zip_code, :string, null:false
    add_column :users, :time_zone, :string, null:false
  end
end
