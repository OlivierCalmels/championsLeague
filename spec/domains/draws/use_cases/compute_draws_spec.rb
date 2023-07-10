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
      let(:country2) { 'Angleterre' }
      let(:country3) { 'Allemagne' }
      let(:country4) { 'Italie' }
      let(:country5) { 'Portugal' }
      let(:country6) { 'Belgique' }
      let(:country7) { 'Espagne' }
      

      let(:team11) { Team.create!(name: 'Chelsea', country: country2) }
      let(:team12) { Team.create!(name: 'Milan AC', country: country4) }
      let!(:group1) do
        Group.create!(tournament: tournament, name: 'My group 1', team1: team11, team2: team12)
      end
      let(:team21) { Team.create!(name: 'Real Madrid', country: country7) }
      let(:team22) { Team.create!(name: 'RB Leipzig', country: country3) }
      let!(:group2) do
        Group.create!(tournament: tournament, name: 'My group 2', team1: team21, team2: team22)
      end

      let(:team31) { Team.create!(name: 'Manchester City', country: country2) }
      let(:team32) { Team.create!(name: 'Dortmund', country: country3) }
      let!(:group3) do
        Group.create!(tournament: tournament, name: 'My group 3', team1: team31, team2: team32)
      end
      let(:team41) { Team.create!(name: 'Benfica', country: country5) }
      let(:team42) { Team.create!(name: 'PSG', country: country1) }
      let!(:group4) do
        Group.create!(tournament: tournament, name: 'My group 4', team1: team41, team2: team42)
      end

      let(:team51) { Team.create!(name: 'Naples', country: country4) }
      let(:team52) { Team.create!(name: 'Liverpool', country: country2) }
      let!(:group5) do
        Group.create!(tournament: tournament, name: 'My group 5', team1: team51, team2: team52)
      end
      let(:team61) { Team.create!(name: 'Porto', country: country5) }
      let(:team62) { Team.create!(name: 'Bruges', country: country6) }
      let!(:group6) do
        Group.create!(tournament: tournament, name: 'My group 6', team1: team61, team2: team62)
      end

      let(:team71) { Team.create!(name: 'Bayern Munich', country: country3) }
      let(:team72) { Team.create!(name: 'Inter Milan', country: country4) }
      let!(:group7) do
        Group.create!(tournament: tournament, name: 'My group 7', team1: team71, team2: team72)
      end
      let(:team81) { Team.create!(name: 'Tottenham', country: country2) }
      let(:team82) { Team.create!(name: 'Francfort', country: country3) }
      let!(:group8) do
        Group.create!(tournament: tournament, name: 'My group 8', team1: team81, team2: team82)
      end

      describe '#call' do
        subject { instance.call(tournament_id: tournament.id) }
        let(:draws_with_team_names) { subject.map {|draw| draw.map { |match| match.map{ |team| team.name}}}}
        # binding.pry
        let(:right_draws) do
           draws_with_team_names.select! do |draw|
            # binding.pry
            draw.include?(["Chelsea","Dortmund"]) &&
            draw.include?(["Benfica","Bruges"]) &&
            draw.include?(["Bayern Munich","PSG"]) &&
            draw.include?(["Tottenham","Milan AC"]) &&
            draw.include?(["Porto","Inter Milan"]) &&
            draw.include?(["Manchester City","RB Leipzig"]) &&
            draw.include?(["Naples","Francfort"]) &&
            draw.include?(["Real Madrid","Liverpool"])

           end
        end

        it "should return the right draws" do
          expect(right_draws).to include(
            [
              ["Chelsea","Dortmund"],
              ["Real Madrid","Liverpool"],
              ["Manchester City","RB Leipzig"],
              ["Benfica","Bruges"],
              ["Naples","Francfort"],
              ["Porto","Inter Milan"],
              ["Bayern Munich","PSG"],
              ["Tottenham","Milan AC"],
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
