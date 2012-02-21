require File.expand_path('../../core_ext/string', __FILE__)

module ZipMeta
  # Contains implementation of the "zip_meta" method, which queries the
  # zip_meta table for a record corresponding to the zipcode passed in.
  module Util
    # Implementation of the "zip_meta" method, which queries the
    # zip_meta table for a record corresponding to the zipcode passed in.
    def zip_meta(zipcode)
      connection = ActiveRecord::Base.connection
      result_set = connection.select_all("SELECT * FROM zip_meta WHERE zip='#{zipcode}'")
      if result_set.count == 0 
        nil
      else
        zip_meta_item = result_set[0]
        zip_meta_item.delete("id")
        zip_meta_item.symbolize_keys!
        zip_meta_item
      end
    end
  end
end