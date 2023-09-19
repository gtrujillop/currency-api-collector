# frozen_string_literal: true

module Clients
  class Currency
    attr_reader :logger

    URL = 'https://api.currencyapi.com/v3'
    API_KEY = ENV['CURRENCY_API_KEY']
    AVAILABLE_ENDPOINTS = %i[currencies latest historical convert]

    def initialize
      @logger = Logger.new(STDOUT)
    end

    def get_currencies(currencies: [])
      response = request(endpoint: 'currencies', querystring: currencies)
      parsed_body = JSON.parse(response.body)
      case response.code
      when 200
        parsed_body['data'].each do |_, currency_data|
          currency = ::Currency.new(currency_data)
          saved = currency.save
          logger.error("unable to save currency #{currency.code} due to: #{currency.errors.full_messages}") unless saved
        end
      else
        raise "errors requesting the currencies API #{parsed_body.inspect}"
      end
    end

    def get_latest_conversions(base_currency:, currencies: [])
      response = request(endpoint: 'latest', querystring: { base_currency:, currencies: })
      currency = ::Currency.where(code: base_currency).first
      raise StandardError.new("currency not found: #{base_currency}") if currency.nil?

      parsed_body = JSON.parse(response.body)
      case response.code
      when 200
        parsed_body['data'].each do |_, currency_data|
          conversion = ::Conversion.find_or_create_by(
            currency_id: currency.id,
            value: currency_data['value'],
            code: currency_data['code'],
            datetime_of_update: parsed_body.dig('meta', 'last_updated_at')
          )
          saved = conversion.persisted?
          logger.error("unable to save conversion #{currency.code} due to: #{conversion.errors.full_messages}") unless saved
        end
      else
        raise "errors requesting the currencies API #{parsed_body.inspect}"
      end
    end

    private

    def request(endpoint:, querystring: nil)
      RestClient.get(
        "#{URL}/#{endpoint}?apikey=#{API_KEY}",
        params: querystring
      )
    end
  end
end
