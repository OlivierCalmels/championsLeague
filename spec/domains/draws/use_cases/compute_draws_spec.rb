# frozen_string_literal: true

require 'rails_helper'

module Draws
  module UseCases
    describe ComputeDraws do
      let(:instance) { described_class.new }
      let(:tournament_id) { 1 }

      describe '#call' do
        subject { instance.call(tournament_id: tournament_id) }

        it "should return 'FooBar' " do
          expect(subject).to eq('FooBar 1')
        end
      end
    end
  end
end
