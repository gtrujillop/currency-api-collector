# frozen_string_literal: true

class Team
  include Mongoid::Document
  field :external_id, type: Integer
  field :name, type: String

  belongs_to :country
end
