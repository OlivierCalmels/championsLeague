# frozen_string_literal: true

module Draws
  module Infrastructure
    class TournamentRepository
      def by_id(id)
        Tournament.includes(groups: %i[team1 team2]).find(id)
      end
    end
  end
end
