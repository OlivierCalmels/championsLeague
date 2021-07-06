class DrawsController < ApplicationController
  attr_accessor :draws_maker

  def index
    @tournament = Tournament.find(params[:tournament_id])
    @create_draws = params[:create_draws] || false
    @draws = {}
    print(@create_draws)
    if @create_draws == "true"
      print("Heyyyyyyy")
      # destroy_draws print(@create_draws)
      DrawsCreationJob.set(wait: 4.seconds).perform_later
    end
    # draws_maker
    # DrawsCreationJob.set(wait: 10.seconds).perform_later()
    Draw.draws_maker(@tournament)
    @draws_ar = Draw.where(tournament_id: @tournament.id).limit(10)
    @draws_ar.each do |draw|
      matches = Match.where(draw_id: Draw.find(draw.id))
      @draws[draw] = matches
    end
  end
end
