# frozen_string_literal: true

require 'rails_helper'

module Draws
  module Infrastructure
    RSpec.describe TournamentRepository do
      let(:instance) { described_class.new }
      describe '#by_id' do
        subject { instance.by_id(tournament.id) }

        let(:tournament) { Tournament.create(name: 'My tournament') }
        let(:group1) { Group.create(tournament_id: tournament.id, name: 'My group 1', team1: team11, team2: team12) }
        let(:team11) { Team.create(name: 'My team 1 1') }
        let(:team12) { Team.create(name: 'My team 1 2') }
        let(:group2) { Group.create(tournament_id: tournament.id, name: 'My group 2', team1: team21, team2: team22) }
        let(:team21) { Team.create(name: 'My team 2 1') }
        let(:team22) { Team.create(name: 'My team 2 2') }

        context 'when id is 1' do
          let(:id) { 1 }
          it "should return the good tournament' " do
            expect(subject).to eq(tournament)
          end
        end
      end
    end
  end
end
