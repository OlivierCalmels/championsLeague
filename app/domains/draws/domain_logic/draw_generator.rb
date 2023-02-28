# frozen_string_literal: true

module Draws
  module DomainLogic
    class DrawGenerator
      def initialize; end

      def call(tournament:)
        teams(tournament)
      end

      private

      def teams((tournament))
        teams = []
        debugger
        tournament.groups
      end
    end
  end
end
