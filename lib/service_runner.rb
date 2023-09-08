# frozen_string_literal: true

class ServiceRunner
  def initialize(service)
    @service = service
  end

  def run
    @service.get_currencies
  end
end
