require 'zip_meta'
require 'rails'
require File.expand_path('../util', __FILE__)
require File.expand_path('../migration_util', __FILE__)

module ZipMeta
  # The ZipMeta railtie implements the "configure_rails_initialization" callback 
  # and adds a "zip_meta" instance method ActionController::Base and ActionView::Base
  class Railtie < Rails::Railtie
    railtie_name :zip_meta
    
    # Initialization callback.  Adds the "zip_meta" method we've defined in the Util module
    # to ActionController::Base and ActionView::Base, so that it can be available 
    # from within all controllers and views.
    initializer "zip_meta.configure_rails_initialization" do
      ActionController::Base.send(:include, ZipMeta::Util)
      ActionView::Base.send(:include, ZipMeta::Util)
    end
  end
end