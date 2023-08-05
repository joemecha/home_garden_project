class RemoveTimeZoneNullConstraintFromUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :time_zone, true
  end
end
