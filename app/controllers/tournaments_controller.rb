class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.all
  end

  def destroy
    puts @tournament = Tournament.find_by(id: params[:id])
    puts @tournament.destroy
    redirect_to tournaments_path
  end

  private

end