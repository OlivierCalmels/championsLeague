class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.all
  end

  def destroy
    @tournament = Tournament.find_by(id: params[:id])
    @tournament.destroy
    redirect_to tournaments_path
  end

end