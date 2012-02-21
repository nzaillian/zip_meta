require 'test_helper'

class ZipMetaTest < ActiveSupport::TestCase
  include ZipMeta::Util
  
  test "migration creates and populates zip_meta table" do
    require File.expand_path('../../lib/generators/templates/create_zip_meta_table', __FILE__)
    CreateZipMetaTable.up

    # a test query, to establish the table has been created...
    begin 
      ActiveRecord::Base.connection.execute("SELECT * FROM zip_meta WHERE zip='00210'")
    rescue ActiveRecord::StatementInvalid
      assert(false, "CreateZipMetaTable migration failed to generate zip_meta table")
    end
    
    # zip_meta method test using a row with known values...
    result = zip_meta('10003')
    assert_equal(result[:zip], '10003')
    assert_equal(result[:city], "New York")
    assert_equal(result[:state], "NY")
    assert_equal(result[:latitude], 40.732509)
    assert_equal(result[:longitude], -73.98935)
    assert_equal(result[:timezone], -5)
  end
end
