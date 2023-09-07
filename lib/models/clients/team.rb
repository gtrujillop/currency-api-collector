# frozen_string_literal: true

module Clients
  class Team
    attr_reader :params

    URL = 'https://v3.football.api-sports.io'
    API_KEY = ENV['SPORTS_API_KEY']
    HOST = 'v3.football.api-sports.io'
    AVAILABLE_ENDPOINTS = {
      countries: { expected_params: %w[name code search] },
      teams: { expected_params: %w[id name code search country] },
      leagues: { expected_params: %w[id name code search country season] }
    }
    HEADERS = { content_type: :json, accept: :json, 'x-rapidapi-key': API_KEY, 'x-rapidapi-host': HOST }

    def initialize(params: {})
      @params = params
    end

    def get
      validate_call!
      response = RestClient::Request.execute(
        method: :get,
        url: "#{URL}/#{params[:endpoint]}",
        headers: params[:params].merge(HEADERS)
      )
      parsed_body = JSON.parse(response.body)
      case response.code
      when 200
        puts parsed_body
        return parsed_body
      else
        raise "errors requesting the sports API #{parsed_body.inspect}"
      end
    end

    private

    def validate_call!
      raise StandardError.new('Invalid endpoint') unless AVAILABLE_ENDPOINTS.keys.include?(params[:endpoint].to_sym)
      # raise unless AVAILABLE_ENDPOINTS.dig(params[:endpoint], :expected_params).include?(params[:params])
    end
  end
end
