# !/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../config/boot'
require_relative '../lib/service_runner'

query = {
  endpoint: 'currencies',
  params: {
    currency: ['USD', 'COP']
  }
}

# query = {
#   endpoint: 'latest',
#   params: {
#     base_currency: 'USD'
#   }
# }

ServiceRunner.new(Clients::Currency.new(params: query)).run
