# frozen_string_literal: true

require 'rails_helper'

module Draws
  module UseCases
    describe ComputeDraws do
      let(:instance) { described_class.new }
      describe '#call' do
        subject { instance.call }

        it "should return 'FooBar' " do
          expect(subject).to eq('FooBar')
        end
      end
    end
  end
end
