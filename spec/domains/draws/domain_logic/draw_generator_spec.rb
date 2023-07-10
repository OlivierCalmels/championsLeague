# frozen_string_literal: true

require 'rails_helper'

module Draws
  module DomainLogic
    RSpec.describe DrawGenerator do
      let(:instance) { described_class.new }

      describe '#list_same_group' do
        subject { instance.list_same_group(teams2_permutations) }

        let(:teams2_permutations) { (1..4).to_a.permutation.to_a }

      end
    end
  end
end
