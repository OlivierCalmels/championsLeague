# frozen_string_literal: true

require 'rails_helper'

module Draws
  module UseCases
    RSpec.describe ComputeDraws do
      let(:instance) { described_class.new }
      # let(:tournament_id) { 1 }

      let!(:tournament) { Tournament.create!(name: 'My tournament') }
      let!(:group1) do
        Group.create!(tournament_id: tournament.id, name: 'My group 1', team1_id: team11.id, team2_id: team12.id)
      end
      let!(:team11) { Team.create!(name: 'My team 1 1') }
      let!(:team12) { Team.create!(name: 'My team 1 2') }
      let!(:group2) do
        Group.create!(tournament_id: tournament.id, name: 'My group 2', team1_id: team21.id, team2_id: team22.id)
      end
      let!(:team21) { Team.create!(name: 'My team 2 1') }
      let!(:team22) { Team.create!(name: 'My team 2 2') }

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
