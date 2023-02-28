# frozen_string_literal: true

require 'rails_helper'

module Draws
  module UseCases
    RSpec.describe ComputeDraws do
      let(:instance) { described_class.new }
      # let(:tournament_id) { 1 }

      let!(:tournament) { Tournament.create!(name: 'My tournament') }
      let!(:group1) do
        Group.create!(tournament: tournament, name: 'My group 1', team1: team11, team2: team12)
      end
      let!(:team11) { Team.create!(name: 'My team 3 1') }
      let!(:team12) { Team.create!(name: 'My team 3 2') }
      let!(:group2) do
        Group.create!(tournament: tournament, name: 'My group 2', team1: team21, team2: team22)
      end
      let!(:team21) { Team.create!(name: 'My team 4 1') }
      let!(:team22) { Team.create!(name: 'My team 4 2') }

      describe '#call' do
        subject { instance.call(tournament_id: tournament.id) }

        it "should return 'FooBar' " do
          # debugger
          expect(subject).to eq('FooBar 1')
        end
      end
    end
  end
end
