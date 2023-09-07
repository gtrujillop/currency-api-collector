# frozen_string_literal: true

class Country
  include Mongoid::Document
  field :name, type: String
  field :code, type: String
  field :latitude, type: BigDecimal
  field :longitude, type: BigDecimal
end
