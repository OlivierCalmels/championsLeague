# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

p "-------------------------"
p "----------SEEDS----------"
p "-------------------------"

p "**********************"
p "****** Destroy *******"
p "**********************"

p "----- groups -----"
Group.destroy_all
p "----- teams -----"
Team.destroy_all
p "----- tounaments -----"
Tournament.destroy_all

p "**********************"
p "***** Tournament *****"
p "**********************"
Tournament.create(name:"2016")
Tournament.create(name:"2017")
Tournament.create(name:"2018")
Tournament.create(name:"2019")
Tournament.create(name:"2020")

p "**********************"
p "***** Teams **********"
p "**********************"

p "----- Bayern -----"
Team.create(name:"Bayern", country:"Allemagne")
p "----- Atletico Madrid -----"
Team.create(name:"Atlético Madrid", country:"Espagne")

p "----- Real Madrid -----"
Team.create(name:"Real Madrid", country:"Espagne")
p "----- Monchenglad -----"
Team.create(name:"Monchenglad", country:"Allemagne")

p "----- Man City -----"
Team.create(name:"Man City", country:"Angleterre")
p "----- Porto -----"
Team.create(name:"Porto", country:"Portugal")

p "----- Liverpool -----"
Team.create(name:"Liverpool", country:"Angleterre")
p "----- Atalanta -----"
Team.create(name:"Atalanta", country:"??")

p "----- Chelsea -----"
Team.create(name:"Chelsea", country:"Angleterre")
p "----- Seville -----"
Team.create(name:"Seville", country:"Espagne")

p "----- Dortmund -----"
Team.create(name:"Dortmund", country:"Allemagne")
p "----- Lazio -----"
Team.create(name:"Lazio", country:"Italie")

p "----- Juventus -----"
Team.create(name:"Juventus", country:"Italie")
p "----- Barcelona -----"
Team.create(name:"Barcelona", country:"Espagne")

p "----- PSG -----"
Team.create(name:"PSG", country:"France")
p "----- RB Leipzig -----"
Team.create(name:"RB Leipzig", country:"??")

p "----- Manchester U -----"
Team.create(name:"Manchester U", country:"Angleterre")
p "----- Istanbul BB -----"
Team.create(name:"Istanbul BB", country:"Turquie")

p "**********************"
p "***** Groups *********"
p "**********************"

p tournament = Tournament.find_by(name:"2020")

p name = "A"
p firstTeam = Team.find_by(name: "Bayern")
p secondTeam = Team.find_by(name: "Atlético Madrid")
p Group.create(tournament_id: tournament.id, team1_id: firstTeam.id, team2_id: secondTeam.id, name: name )

p name = "B"
p firstTeam = Team.find_by(name: "Real Madrid")
p secondTeam = Team.find_by(name: "Monchenglad")
p Group.create(tournament_id: tournament.id, team1_id: firstTeam.id, team2_id: secondTeam.id, name: name )
p name = "C"
p firstTeam = Team.find_by(name: "Man City")
p secondTeam = Team.find_by(name: "Porto")
p Group.create(tournament_id: tournament.id, team1_id: firstTeam.id, team2_id: secondTeam.id, name: name )
p name = "D"
p firstTeam = Team.find_by(name: "Liverpool")
p secondTeam = Team.find_by(name: "Atalanta")
p Group.create(tournament_id: tournament.id, team1_id: firstTeam.id, team2_id: secondTeam.id, name: name )
p name = "E"
p firstTeam = Team.find_by(name: "Chelsea")
p secondTeam = Team.find_by(name: "Seville")
p Group.create(tournament_id: tournament.id, team1_id: firstTeam.id, team2_id: secondTeam.id, name: name )
p name = "F"
p firstTeam = Team.find_by(name: "Dortmund")
p secondTeam = Team.find_by(name: "Lazio")
p Group.create(tournament_id: tournament.id, team1_id: firstTeam.id, team2_id: secondTeam.id, name: name )
p name = "G"
p firstTeam = Team.find_by(name: "Juventus")
p secondTeam = Team.find_by(name: "Barcelona")
p Group.create(tournament_id: tournament.id, team1_id: firstTeam.id, team2_id: secondTeam.id, name: name )
p name = "H"
p firstTeam = Team.find_by(name: "PSG")
p secondTeam = Team.find_by(name: "RB Leipzig")
p Group.create(tournament_id: tournament.id, team1_id: firstTeam.id, team2_id: secondTeam.id, name: name )
p "-------------------------"
p "----------SEEDS END------"
p "-------------------------"