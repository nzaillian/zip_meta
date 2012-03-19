$:.push File.expand_path("../lib", __FILE__)

require "zip_meta/version"

Gem::Specification.new do |s|
  s.name        = "zip_meta"
  s.version     = ZipMeta::VERSION
  s.authors     = ["Nicholas Zaillian"]
  s.email       = ["contact@zaillian.com"]
  s.homepage    = "https://github.com/nzaillian/zip_meta"
  s.summary     = "Drop-in zip code meta info queries for your Rails app"
  s.description = "A gem that uses data formerly available from CivicSpace Labs (included with this project in CSV format in the lib/data directory) in conjunction with ActiveRecord to let you add fast zip code meta info lookups to your Rails app."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.1.0"

  s.add_development_dependency "sqlite3"
end
