class DrawsController < ApplicationController
  attr_accessor :draws_maker

  def index
    @tournament = Tournament.find(params[:tournament_id])
    @create_draws = params[:create_draws] || false
    @draws = {}
    DrawsCreationJob.set(wait: 4.seconds).perform_later if @create_draws == "true"
    # destroy_draws
    # draws_maker
    # DrawsCreationJob.set(wait: 10.seconds).perform_later()
    @draws_ar = Draw.where(tournament_id: @tournament.id)
    @draws_ar.each do |draw|
      matches = Match.where(draw_id: Draw.find(draw.id))
      @draws[draw] = matches
    end
  end


end
