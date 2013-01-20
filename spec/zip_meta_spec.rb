require File.expand_path('../spec_helper', __FILE__)
require File.expand_path('../../lib/zip_meta/util', __FILE__)

describe ZipMeta do 
  it "should supply a functional zip_meta meta info querying method" do
    include ZipMeta::Util
  end
end