# frozen_string_literal: true

env = ENV['ENV'] ||= ENV['RACK_ENV'] ||= 'development'

require 'rubygems'
require 'bundler/setup'
require 'grape'
require 'rest-client'
require 'pry'
require 'dotenv/load'

Bundler.require
Bundler.require(env.to_sym)

Dir['.config/initializers/**/*.rb'].each(&method(:require))
Dir['.lib/models/clients/*.rb'].each(&method(:require))
Dir['.lib/models/**/*.rb'].each(&method(:require))
Dir['.lib/models/*.rb'].each(&method(:require))
Dir['./lib/api/**/*.rb'].each(&method(:require))
Dir['./lib/**/*.rb'].each(&method(:require))
