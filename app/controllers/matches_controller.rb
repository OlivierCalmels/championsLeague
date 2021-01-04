class MatchesController < ApplicationController

  def index
    p "----------------------------------"
    p @tournament = Tournament.find(params[:tournament_id])
    p @groups = Group.where(tournament_id: @tournament.id)
    raise
  end


end