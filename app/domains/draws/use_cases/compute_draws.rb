# frozen_string_literal: true

module Draws
  module UseCases
    # This class is responsible for computing the draws of a tournament
    class ComputeDraws
      def initialize(draw_repository: 'DrawRepository.new')
        @draw_repository = draw_repository
        @draw_generator = 'DrawGenerator.new'
      end

      def call(tournament_id:)
        # teams = tournament.teams
        # "FooBar #{tournament_id}"
      end
    end
  end
end
