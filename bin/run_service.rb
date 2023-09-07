# !/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../config/boot'
require_relative '../lib/service_runner'

query = {
  endpoint: 'teams',
  params: {
    search: 'Atletico Nacional'
  }
}

ServiceRunner.new(Clients::Team.new(params: query)).run
