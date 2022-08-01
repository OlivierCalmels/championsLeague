# frozen string literal: true

module Draws
  module UsesCases
    class ComputeDraws
      def initialize(draw_repository:)
        @draw_repository = draw_repository
      end

      def call(tournament:)
        teams = tournament.teams
      end
    end
  end
end
