class GroupsController < ApplicationController

  def index
    @tournament = Tournament.find(params[:tournament_id])
    @groups = Group.all
  end

end