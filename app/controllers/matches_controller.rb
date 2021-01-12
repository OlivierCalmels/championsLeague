class MatchesController < ApplicationController
  def index
    p "----------------------------------"
    @tournament = Tournament.find(params[:tournament_id])
    p @groups = Group.where(tournament_id: @tournament.id)
    @teams = []
    @groups.each do |group|
      p group.team1
      @teams << group.team1
      p group.team2
      @teams << group.team2
    end
    create_all_matches
  end

  # private

  def create_all_matches
    @teams = Team.where(tournament_id: Tournament.find_by(name: name))
    puts @teams
  end
end
