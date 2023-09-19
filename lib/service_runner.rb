# frozen_string_literal: true

class ServiceRunner
  def initialize(service)
    @service = service
  end

  def run
    @service.get_currencies
    @service.get_latest_conversions(base_currency: 'USD')
  end
end
