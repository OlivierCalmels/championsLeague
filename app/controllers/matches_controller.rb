# frozen_string_literal: true

class MatchesController < ApplicationController
  def index
    p '----------------------------------'
    @tournament = Tournament.find(params[:tournament_id])
    p @groups = Group.where('tournament_id = ?', @tournament.id)
    @teams = []
    @groups.each do |group|
      p group.team1
      @teams << group.team1
      p group.team2
      @teams << group.team2
    end
  end

  # private
end
