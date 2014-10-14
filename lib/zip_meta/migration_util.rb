require File.expand_path('../../core_ext/string', __FILE__)

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

      vals_arr = []
            
      len = rows.length      
      rows.each_with_index do |row, index|
        vals = "('#{row[0]}', '#{row[1].sql_escape_single_quotes}', '#{row[2].sql_escape_single_quotes}', #{row[3]}, #{row[4]}, #{row[5]})"

        vals_arr << vals
      end

      query = "INSERT INTO zip_meta(#{keys[0]}, #{keys[1]}, #{keys[2]}, #{keys[3]}, #{keys[4]}, #{keys[5]}) " + \
      "VALUES #{vals_arr.join(', ')}"
      connection.execute(query)

      puts "adding zip meta info data - complete\n"              
    end  
  end
end