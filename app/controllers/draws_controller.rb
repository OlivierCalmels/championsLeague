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
      Draw.draws_maker(@tournament)
      # DrawsCreationJob.set(wait: 2.seconds).perform_later
    end
    @draws_ar = Draw.where(tournament_id: @tournament.id).limit(10)
    @draws_ar.each do |draw|
      matches = Match.where(draw_id: Draw.find(draw.id))
      @draws[draw] = matches # @draws is a hash with draws as key and matches as value
    end
  end

  def destroy_all
    @tournament = Tournament.find(params[:tournament_id])
    @draws = {}
    Draw.destroy_draws(@tournament)
    redirect_to tournament_draws_path
  end
end
