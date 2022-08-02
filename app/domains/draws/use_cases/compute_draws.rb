# frozen_string_literal: true

module Draws
  module UseCases
    class ComputeDraws
      def initialize(draw_repository: 'DrawRepository.new')
        @draw_repository = draw_repository
        @draw_generator = 'DrawGenerator.new'
      end

      def call(tournament: 'my tournamenrt')
        # teams = tournament.teams

        'FooBar'
      end
    end
  end
end
