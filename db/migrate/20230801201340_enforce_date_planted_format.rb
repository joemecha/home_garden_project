class EnforceDatePlantedFormat < ActiveRecord::Migration[7.0]
  
  # Cast date_planted to text before matching against the REGEX; prevents PG::UndefinedFunction
  # Enforces format YYYY-MM-DD
  def up
    execute <<-SQL
      ALTER TABLE crops
      ADD CONSTRAINT enforce_date_planted_format
      CHECK (date_planted::text ~ '^\\d{4}-\\d{2}-\\d{2}$');
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE crops
      DROP CONSTRAINT enforce_date_planted_format;
    SQL
  end
end
