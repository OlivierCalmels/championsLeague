# frozen_string_literal: true

module Draws
  module Infrastructure
    class TournamentRepository
      def find(id)
        # Tournament.combine(groups: :teams).find(id)

        groups = Group.where(tournament_id: id)

        groups.map do |group|
          team1 = Team.find(group.team1_id)
          team2 = Team.find(group.team2_id)
          DomainLogic::Group.from_model(group: group, team1: team1, team2: team2)
        end
      end
    end
  end
end
