ENV["RAILS_ENV"] ||= 'test'

require 'rubygems'
gem 'rspec', '~>2.12.0'

require 'active_record'
require 'active_record/fixtures'
require 'action_controller'
require 'rspec/mocks'
#require 'rspec/mocks/spec_methods'
#require 'rspec/mocks/standalone'
#require 'rspec/rails'

require File.dirname(__FILE__) + '/../lib/userstamp'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
load 'support/schema.rb'