# frozen_string_literal: true

module Draws
  module DomainLogic
    class DrawGenerator
      def initialize; end

      def call(tournament:)
        teams = team_for(tournament: tournament)
        generate_draws(teams)
      end

      private

      def team_for(tournament:)
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
        # teams = (1..8).to_a
        number_of_teams=teams.count
        number_of_matches_per_draw = teams.count / 2
        teams_per_match = 2
        # binding.pry

        all_draws = teams
                      .permutation
                      .map { |permutation| permutation.each_slice(teams_per_match) }
                      .map do |draw|
                        draw.map do |match|
                          match.sort_by(&:database_id)
                        end.sort! do |match1, match2|
                          match1.first.database_id <=>match2.first.database_id
                        end
                      end
                      .uniq   
                    # [[[1,2], [3,4]], [[1,3], [2,4]]]  
                      



      end
    end
  end
end
