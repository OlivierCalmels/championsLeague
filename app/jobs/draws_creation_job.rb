class DrawsCreationJob < ApplicationJob
  # include Sidekiq
  queue_as :default

  def perform(*)
    # Do something later

    # destroy_draws
    # draws_maker
    Draw.draws_maker
  end
end
