# frozen_string_literal: true

module Draws
  module DomainLogic
    class Tournament

    def self.from_model(tournament, groups)
    new(
      database_id: tournament.id,
      name: tournament.name,
      groups:)
    end
  end
end
