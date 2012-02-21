module ZipMeta
  # Contains a static "load_zipcode_data" method that parses 
  # the "zipcodes.csv" file and loads each row into 
  # the "zip_meta" database table.
  class MigrationUtil
    # Method to parse the "zipcodes.csv" file and load each row into 
    # the "zip_meta" database table.
    def self.load_zipcode_data
      require 'csv'

      csv_path = File.expand_path('../../data/zipcode.csv', __FILE__)
      csv_data = CSV.open(csv_path, 'r')
      rows = []
      csv_data.each do |row|
        rows << row
      end
      keys = rows[0]
      rows.delete_at(0)

      connection = ActiveRecord::Base.connection

      rows.each do |row|
        query = "INSERT INTO zip_meta(#{keys[0]}, #{keys[1]}, #{keys[2]}, #{keys[3]}, #{keys[4]}, #{keys[5]}) " + \
                 "VALUES ('#{row[0]}', '#{row[1].sql_escape_single_quotes}', '#{row[2].sql_escape_single_quotes}', #{row[3]}, #{row[4]}, #{row[5]})"
        connection.execute(query)
      end
    end
  end
end