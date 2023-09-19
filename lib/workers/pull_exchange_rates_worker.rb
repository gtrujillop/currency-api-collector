require 'sidekiq-scheduler'
require_relative '../../config/boot'

module Workers
  class PullExchangeRatesWorker
    include Sidekiq::Worker

    def perform
      Clients::Currency.new.get_latest_conversions(base_currency: 'USD', currencies: [])
      Clients::Currency.new.get_latest_conversions(base_currency: 'COP', currencies: [])
      Clients::Currency.new.get_latest_conversions(base_currency: 'EUR', currencies: [])
      Clients::Currency.new.get_latest_conversions(base_currency: 'CAD', currencies: [])
      Clients::Currency.new.get_latest_conversions(base_currency: 'RUB', currencies: [])
    end
  end
end
