# frozen_string_literal: true

module Draws
  module DomainLogic
    class DrawGenerator
      def initialize; end

      def call(tournament:)
        teams = teams_for(tournament: tournament)
        generate_draws(teams)

           # ------Sandbox------
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

      def generate_draws(teams)
        teams = (1..4).to_a
        number_of_matches_per_draw = teams.count / 2
        all_draws = teams
                      .permutation
                      .map do |draw|
                        draw.each_slice(2)
                        .map do |match|
                          match.sort
                        end
                        .sort
                      end
                      .uniq      
      end
    end
  end
end
