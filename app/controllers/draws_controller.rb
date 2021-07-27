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
    @team1 = Team.find_by('name = ?', params[:team1])
    @team2 = Team.find_by('name = ?', params[:team2])
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

    unless @team1.nil? || @team2.nil?
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
    # All draws of this tournament
    all_draws = Draw.where('tournament_id = ?', @tournament.id) || 0
    all_draws_count = all_draws.count
    p "Tournament id :#{@tournament.id}"

    # All draws of this tournament witch a match between the selected teams
    all_draws_2 = tournament.draws
    all_draws_3 = tournament.draws.matches

    #all_matches = Draw.matches# .joins(:matches).where('match.team1_id = ?' => team1.id).where('tournament_id = ?', tournament.id) #("INNER JOIN matches ON matches.draw_id = draws.id ").where('tournament_id = ?', tournament.id) #tournament_id: @tournament.id") || p all matches
    raise
    # good_draws = all_draws.where(team1_id: team1.id)
    # good_draws = Draws.Matches.all
    return "Coucou"

  end
end
