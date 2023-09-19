require 'sidekiq-scheduler'
require_relative '../../config/boot'

module Workers
  class PullCurrenciesDataWorker
    include Sidekiq::Worker

    def perform
      Clients::Currency.new.get_currencies
    end
  end
end
