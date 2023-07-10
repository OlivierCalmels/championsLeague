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

      let(:team11) { Team.create!(name: 'My team 11', country: country1) }
      let(:team12) { Team.create!(name: 'My team 12', country: country1) }
      let!(:group1) do
        Group.create!(tournament: tournament, name: 'My group 1', team1: team11, team2: team12)
      end
      let(:team21) { Team.create!(name: 'My team 21', country: country1) }
      let(:team22) { Team.create!(name: 'My team 22', country: country1) }
      let!(:group2) do
        Group.create!(tournament: tournament, name: 'My group 2', team1: team21, team2: team22)
      end

      let(:team31) { Team.create!(name: 'My team 31', country: country1) }
      let(:team32) { Team.create!(name: 'My team 32', country: country1) }
      let!(:group3) do
        Group.create!(tournament: tournament, name: 'My group 3', team1: team31, team2: team32)
      end
      let(:team41) { Team.create!(name: 'My team 41', country: country1) }
      let(:team42) { Team.create!(name: 'My team 42', country: country1) }
      let!(:group4) do
        Group.create!(tournament: tournament, name: 'My group 4', team1: team41, team2: team42)
      end

      # let(:team51) { Team.create!(name: 'My team 51', country: country1) }
      # let(:team52) { Team.create!(name: 'My team 52', country: country1) }
      # let!(:group5) do
      #   Group.create!(tournament: tournament, name: 'My group 5', team1: team51, team2: team52)
      # end
      # let(:team61) { Team.create!(name: 'My team 61', country: country1) }
      # let(:team62) { Team.create!(name: 'My team 62', country: country1) }
      # let!(:group6) do
      #   Group.create!(tournament: tournament, name: 'My group 6', team1: team61, team2: team62)
      # end

      # let(:team71) { Team.create!(name: 'My team 71', country: country1) }
      # let(:team72) { Team.create!(name: 'My team 72', country: country1) }
      # let!(:group7) do
      #   Group.create!(tournament: tournament, name: 'My group 7', team1: team71, team2: team72)
      # end
      # let(:team81) { Team.create!(name: 'My team 81', country: country1) }
      # let(:team82) { Team.create!(name: 'My team 82', country: country1) }
      # let!(:group8) do
      #   Group.create!(tournament: tournament, name: 'My group 8', team1: team81, team2: team82)
      # end

      describe '#call' do
        subject { instance.call(tournament_id: tournament.id) }
        let(:draws_with_team_ids) { subject.map {|draw| draw.map { |match| match.map{ |team| team.database_id}}}}

        it "should return the right draws" do
          # binding.pry
          expect(draws_with_team_ids).to match_array(
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

      # describe '#list_same_group' do
      #   subject { instance.list_same_group(teams2_permutations) }

      #   let(:teams2_permutations) { (1..4).to_a.permutation.to_a }

      #   it "sould return the right list of permutation" do
      #     binding.pry
      #     expect(subject).to eq(
      #       [
      #         1,2,3,4,5,6
      #       ]
      #     )
      #   end

      # end
    end
  end
end
