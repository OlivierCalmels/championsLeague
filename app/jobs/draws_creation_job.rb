class DrawsCreationJob < ApplicationJob
  queue_as :default

  def perform(*)
    # Do something later

    p tournament = Tournament.find_by(name:"2020")
    p dr1 = Draw.create(tournament_id: tournament.id)
    p name = "Jobs test"
    p first_team = Team.find_by(name: "Bayern")
    p second_team = Team.find_by(name: "Monchenglad")
    p Match.create(draw_id: dr1.id, team1_id: first_team.id, team2_id: second_team.id, name: name )
    raise
  end
end
