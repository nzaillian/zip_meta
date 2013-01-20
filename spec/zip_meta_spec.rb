require File.expand_path('../spec_helper', __FILE__)
require File.expand_path('../../lib/zip_meta/migration_util', __FILE__)
require File.expand_path('../../lib/zip_meta/util', __FILE__)
require File.expand_path('../../test/dummy/config/environment', __FILE__)

describe ZipMeta do 
  before do    
    ::ActiveRecord::Migration.class_eval do
      create_table :zip_meta, :force => true do |t|
        t.string :zip
        t.string :city
        t.string :state
        t.float :latitude
        t.float :longitude
        t.integer :timezone
      end
      add_index :zip_meta, :zip
      add_index :zip_meta, :timezone
      
      class DummyClass
        include ZipMeta::Util
      end
    end

    # create dummy table, populate w/ 1 row of test data    
    keys = ["zip", "city", "state", "latitude", "longitude", "timezone", "dst"]

    vals = "('10003', 'New York', 'NY', 40.732509, -73.98935, -5)"
    
    query = "INSERT INTO zip_meta(#{keys[0]}, #{keys[1]}, #{keys[2]}, #{keys[3]}, #{keys[4]}, #{keys[5]}) " + \
    "VALUES #{vals}"          

    connection = ActiveRecord::Base.connection

    connection.execute(query)
  end

  it "should supply a functional zip_meta meta info querying method" do
    c = DummyClass.new
    c.zip_meta("10003").should_not == nil

  end

  it "should produce valid zip entries" do
    c = DummyClass.new
    result = c.zip_meta("10003")
    result[:zip].should == '10003'
    result[:city].should == "New York"
    result[:state].should == "NY"
    result[:latitude].should == 40.732509
    result[:longitude].should == -73.98935
    result[:timezone].should == -5    
  end
end