class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.all
  end

  private

end