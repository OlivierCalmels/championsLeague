class DrawsCreationJob < ApplicationJob
  # include Sidekiq
  queue_as :default

  def perform(*)
    # Do something later

    # destroy_draws
    # draws_maker
    raise
    Draw.draws_maker
    raise

  end
end
