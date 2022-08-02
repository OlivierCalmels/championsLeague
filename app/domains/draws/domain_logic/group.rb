# frozen_string_literal: true

module Draws
  module DomainLogic
    class Group

      def initialize(database_id:, name:, team1:, team2:)
        @database_id = database_id
        @name = name
        @team1 = team1
        @team2 = team2
      end

      def self.from_model(group:, team1:, team2:)
        new(
          database_id: group.id,
          name: group.name,
          team1: team1,
          team2: team2
        )
      end
    end
  end
end
