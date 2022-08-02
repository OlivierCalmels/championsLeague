# frozen_string_literal: true

class DrawsCreationJob < ApplicationJob
  # include Sidekiq
  queue_as :default

  def perform(*)
    Draw.draws_maker(@tournament)
  end
end
