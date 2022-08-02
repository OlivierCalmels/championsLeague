# frozen_string_literal: true

module Draws
  module UseCases
    # This class is responsible for computing the draws of a tournament
    class ComputeDraws
      
      def initialize(draw_repository: 'DrawRepository.new')
        @draw_repository = draw_repository
        @draw_generator = 'DrawGenerator.new'
      end


      def call(tournament:)
        # teams = tournament.teams

        'FooBar'
      end
    end
  end
end
