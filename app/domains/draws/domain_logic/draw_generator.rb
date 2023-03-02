# frozen_string_literal: true

module Draws
  module DomainLogic
    class DrawGenerator
      def initialize; end

      def call(tournament:)
        teams = teams_for(tournament: tournament)
      end

      private

      def teams_for(tournament:)
        # debugger
        groups = tournament.groups
        groups.each do |group|
          debugger
          DomainLogic::Team.from_model(team: group.team1, group_id: group.id, placement: 'first')
          DomainLogic::Team.from_model(team: group.team2, group_id: group.id, placement: 'second')
        end
        # groups = Group.where(tournament_id: id)

        # groups.map do |group|
        #   team1 = Team.find(group.team1_id)
        #   team2 = Team.find(group.team2_id)
        #   DomainLogic::Group.from_model(group: group, team1: team1, team2: team2)
        # end
      end
    end
  end
end
