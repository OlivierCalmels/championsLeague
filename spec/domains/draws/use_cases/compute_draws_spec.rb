# frozen_string_literal: true

require 'rails_helper'

module Draws
  module UseCases
    RSpec.describe ComputeDraws do
      let(:instance) { described_class.new }
      # let(:tournament_id) { 1 }

      let(:tournament) { Tournament.create!(name: 'My tournament') }
      let(:group1) do
        Group.create!(tournament: tournament, name: 'My group 1', team1: team11, team2: team12)
      end

      let(:country1) { 'France' }

      let(:team11) { Team.create!(name: 'My team 1 1', country: country1) }
      let(:team12) { Team.create!(name: 'My team 1 2', country: country1) }
      let!(:group1) do
        Group.create!(tournament: tournament, name: 'My group 1', team1: team11, team2: team12)
      end
      let(:team21) { Team.create!(name: 'My team 2 1', country: country1) }
      let(:team22) { Team.create!(name: 'My team 2 2', country: country1) }
      let!(:group2) do
        Group.create!(tournament: tournament, name: 'My group 2', team1: team21, team2: team22)
      end

      describe '#call' do
        subject { instance.call(tournament_id: tournament.id) }

        it "should return the right draws " do
          # debugger
          expect(subject).to match_array(
            [
              [
                [1, 2], [3, 4]
              ],
              [
                [1, 3], [2, 4]
              ], 
              [ [1, 4], [2, 3]
              ]
            ]
            )
        end
      end
    end
  end
end
