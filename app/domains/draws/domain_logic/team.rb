# frozen_string_literal: true

module Draws
  module DomainLogic
    class Team
      def self.from_model(team)
        new(
          database_id: team.id,
          name: team.name,
          country: team.country
        )
      end
    end
  end
end
