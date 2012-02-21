class CreateZipMetaTable < ActiveRecord::Migration
  def self.up
    create_table :zip_meta do |t|
      t.string :zip
      t.string :city
      t.string :state
      t.float :latitude
      t.float :longitude
      t.integer :timezone
    end
    add_index :zip_meta, :zip
    add_index :zip_meta, :timezone
    
    # finally, load the data...
    ZipMeta::MigrationUtil.load_zipcode_data
  end

  def self.down
    drop_table :zip_meta
  end
end