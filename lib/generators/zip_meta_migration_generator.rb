require 'rails/generators'
require 'rails/generators/migration'

# Generates a timestamped migration file containing the CreateZipMetaTable 
# migration, which creates the "zip_meta" table and populates it with data from 
# "zipcodes.csv", and drops this migration file into the user's "app/db/migrations" directory.
class ZipMetaMigrationGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  source_root File.expand_path("../templates", __FILE__)

  def self.next_migration_number(path)
      Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  def create_migration_file
    migration_template "create_zip_meta_table.rb", "db/migrate/create_zip_meta_table.rb"
  end  
end