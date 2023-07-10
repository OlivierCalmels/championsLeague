# frozen_string_literal: true

module Draws
  module DomainLogic
    class Team
      attr_accessor :database_id, :group_id, :country, :name #:placement

      def initialize(database_id:, name:, country:, group_id:, placement:)
        @database_id = database_id
        @name = name
        @country = country
        @group_id = group_id
        @placement = placement
      end

      def self.from_model(team:, group_id:, placement:)
        # debugger
        new(
          database_id: team.id,
          name: team.name,
          country: team.country,
          group_id: group_id,
          placement: placement
        )
      end
    end
  end
end
