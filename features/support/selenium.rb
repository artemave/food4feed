require 'rubygems'

ENV["RAILS_ENV"] = "cucumber"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')

require 'cucumber/rails/world'
require 'cucumber/rails/active_record'
require 'cucumber/web/tableish'


require 'webrat'
require 'webrat/core/matchers'

Webrat.configure do |config|
  config.mode = :selenium
  config.application_environment = :cucumber
  config.selenium_browser_startup_timeout = 60
  config.selenium_browser_key = '*firefox3 /home/artem/firefox/firefox-bin'
end

World(Webrat::Selenium::Matchers)

Cucumber::Rails::World.use_transactional_fixtures = false

# How to clean your database when transactions are turned off. See
# http://github.com/bmabey/database_cleaner for more info.
if defined?(ActiveRecord::Base)
  begin
    require 'database_cleaner'
    require 'database_cleaner/cucumber'
    DatabaseCleaner.strategy = :truncation
  rescue LoadError => ignore_if_database_cleaner_not_present
  end
end
