# frozen_string_literal: true

module Draws
  module DomainLogic
    class DrawGenerator
      def initialize; end

      def call(tournament:)
        teams = teams_for(tournament: tournament)

        # ------Sandbox------
        teams = (1..4).to_a
        debugger
        number_of_matches_per_draw = teams.count / 2
        all_matches = teams.combination(2).to_a
        # [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]
        all_draws = all_matches.combination(number_of_matches_per_draw).to_a
        # [
        #  [[1, 2], [1, 3]],
        #  [[1, 2], [1, 4]],
        #  [[1, 2], [2, 3]],
        #  [[1, 2], [2, 4]],
        #  [[1, 2], [3, 4]],
        #  [[1, 3], [1, 4]],
        #  [[1, 3], [2, 3]],
        #  [[1, 3], [2, 4]],
        #  [[1, 3], [3, 4]],
        #  [[1, 4], [2, 3]],
        #  [[1, 4], [2, 4]],
        #  [[1, 4], [3, 4]],
        #  [[2, 3], [2, 4]],
        #  [[2, 3], [3, 4]],
        #  [[2, 4], [3, 4]]
        # ]
        # ##############
      end

      private

      def teams_for(tournament:)
        # debugger
        groups = tournament.groups
        teams = groups.map do |group|
          [
            DomainLogic::Team.from_model(team: group.team1, group_id: group.id, placement: 'first'),
            DomainLogic::Team.from_model(team: group.team2, group_id: group.id, placement: 'second')
          ]
        end
        teams.flatten
      end
    end
  end
end
