class DrawsController < ApplicationController
  attr_accessor :draws_maker

  def index
    @tournament = Tournament.find(params[:tournament_id])
    @create_draws = params[:create_draws] || false
    @draws = {}
    @per_page = params[:per_page] || 10
    @groups = Group.where('tournament_id = ?',  @tournament.id)
    @teams1 = []
    @teams2 = []
    @teams = []
    @team1 = Team.where('name = ?', params[:team1])
    @team2 = Team.where('name = ?', params[:team2])
    @groups.each do |group|
      @teams1 << group.team1.name
      @teams2 << group.team2.name
    end
    @teams = @teams1 + @teams2
    # print(@create_draws)
    if @create_draws == "true"
      print("Heyyyyyyy")
      # destroy_draws print(@create_draws)
      Draw.draws_maker(@tournament)
      # DrawsCreationJob.set(wait: 2.seconds).perform_later
    end

    unless @team1.count.zero? || @team2.count.zero?
      print("Heyyyyyyy PROBA")
      # destroy_draws print(@create_draws)
      @proba = probability(@tournament, @team1, @team2)
      # DrawsCreationJob.set(wait: 2.seconds).perform_later
    end
    @first_draw_id = Draw.where('tournament_id = ?',  @tournament.id).nil? ? nil : Draw.where('tournament_id = ?',  @tournament.id).first.id
    @draws_ar = Draw.where('tournament_id = ?',  @tournament.id).paginate(per_page: @per_page, page: params[:page]) # .limit(10)
    @draws_ar.each do |draw|
      matches = Match.where('draw_id = ?', Draw.find(draw.id))
      @draws[draw] = matches # @draws is a hash with draws as key and matches as value
    end
  end

  def destroy_all
    @tournament = Tournament.find(params[:tournament_id])
    @draws = {}
    Draw.destroy_draws(@tournament)
    redirect_to tournament_draws_path
  end

  def probability(tournament, team1, team2)
    all_draws = Draw.where('tournament_id = ?', @tournament.id) || 0
    all_draws_count = all_draws.count
    # all_matches = Match.where(tournament_id: @tournament.id) || 0
    raise
    # good_draws = all_draws.where(team1_id: team1.id)
    # good_draws = Draws.Matches.all
    return "Coucou"

  end
end
