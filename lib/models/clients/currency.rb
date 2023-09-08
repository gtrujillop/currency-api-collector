# frozen_string_literal: true

module Clients
  class Currency
    attr_reader :params, :logger

    URL = 'https://api.currencyapi.com/v3'
    API_KEY = ENV['CURRENCY_API_KEY']
    AVAILABLE_ENDPOINTS = %i[currencies latest historical convert]

    def initialize(params: {})
      @params = params
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
          currency = ::Currency.new(currency_data)
          saved = currency.save
          logger.error("unable to save currency #{currency.code} due to: #{currency.errors.full_messages}") unless saved
        end
      else
        raise "errors requesting the currencies API #{parsed_body.inspect}"
      end
    end

    private

    def request(endpoint:, querystring: nil)
      validate_call!
      RestClient.get(
        "#{URL}/#{endpoint}?apikey=#{API_KEY}",
        params: querystring
      )
    end

    def validate_call!
      raise StandardError.new('Invalid endpoint') unless AVAILABLE_ENDPOINTS.include?(params[:endpoint].to_sym)
    end
  end
end
