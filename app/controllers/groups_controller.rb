class GroupsController < ApplicationController

  def index
    @tournament = Tournament.find(params[:tournament_id])
    @groups = Group.all
  end

  def show
    @tournament = Tournament.find(params[:tournament_id])
    @group = Group.find(params[:id])
    @team1 = Team.find(@group.team1_id)
    @team2 = Team.find(@group.team2_id)
  end
end