# Draw Controller
# Methods:
#   -index
#   -destroy_all
#   -probability
class DrawsController < ApplicationController
  attr_accessor :draws_maker

  def index
    @tournament = Tournament.find(params[:tournament_id])
    @create_draws = params[:create_draws] || false
    @draws = {}
    @per_page = params[:per_page] || 10
    @groups = Group.where('tournament_id = ?', @tournament.id)
    @teams1 = []
    @teams2 = []
    @teams = []
    @team1 = Team.find_by('name = ?', params[:team1])
    @team2 = Team.find_by('name = ?', params[:team2])

    @proba = ''

    @groups.each do |group|
      @teams1 << group.team1.name
      @teams2 << group.team2.name
    end

    @teams = @teams1 + @teams2

    # print(@create_draws)
    if @create_draws == 'true'
      # destroy_draws print(@create_draws)
      Draw.draws_maker(@tournament)
      # DrawsCreationJob.set(wait: 2.seconds).perform_later
    end

    @first_draw_id = if Draw.where('tournament_id = ?', @tournament.id).count.zero?
                       nil
                     else
                       Draw.where('tournament_id = ?', @tournament.id).first.id
                     end
    @draws_ar = Draw.where('tournament_id = ?', @tournament.id)
                    .paginate(per_page: @per_page, page: params[:page]) # .limit(10)
    @draws_ar.each do |draw|
      matches = Match.where('draw_id = ?', Draw.find(draw.id))
      @draws[draw] = matches # @draws is a hash with draws as key and matches as value
    end
    unless @draws.count.zero?
      # destroy_draws print(@create_draws)
      proba = Draw.probability(@tournament, @team1, @team2)
      @proba = "Ces équipes se rencontrent dans #{@proba[2]} tirages sur les #{@proba[0]} tirages possibles. Elles ont donc #{@proba[3]} de chances de se rencontrer en début de phase finale."
      # DrawsCreationJob.set(wait: 2.seconds).perform_later
    end
  end

  def destroy_all
    @tournament = Tournament.find(params[:tournament_id])
    @draws = {}
    Draw.destroy_draws(@tournament)
    redirect_to tournament_draws_path
  end
end
