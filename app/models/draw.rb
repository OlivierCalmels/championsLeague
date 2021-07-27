class Draw < ApplicationRecord
  belongs_to :tournament
  has_many :matches

  def self.destroy_draws(tournament)
    p draws = Draw.where('tournament_id = ?', tournament.id) # params[:tournament_id])
    draws.each do |draw|
      p matches = Match.where('draw_id = ?', draw.id)
      p matches.destroy_all
      draw.destroy
    end
  end

  def self.draws_maker(tournament)
    tournament = Tournament.find(tournament.id) # params[:tournament_id])
    destroy_draws(tournament)
    @groups = Group.where('tournament_id = ?', tournament.id)
    teams1 = []
    teams2 = []
    @groups.each do |group|
      teams1 << group.team1
      teams2 << group.team2
    end
    teams = teams1 + teams2

    p start = Time.now
    # permutations(@teams) # [1,2,3,4,5]) Version 1 de permut
    # matching(@teams1, @teams2)        Version 2 de permut
    uniques_draws = combining(teams, teams1, teams2) # Version 3 de permut
    draws_creation(uniques_draws, tournament)

    p "The end is coming....................."
    p start
    p Time.now
    p "temps = #{Time.now - start}"
    p "@groups.count = #{@groups.count}"   
    # p "nb de permut: #{call_permutations_num}"
    # p ("Toutes permut #{call_permutations_num}")
    # p ("Non_Valid permut #{non_valid_permutations}")
    # p ("Draws #{permut_num}")
    # @draws = @teams.permutation.to_a
    p '--------------------'
    p 'finished!'
    p '--------------------'
  end

  def self.permutations(array, i=0) # testing all permutations
    # puts "this is i at the beginning: #{i}, this is the array size: #{array.size}"
    # p array if i == array.size
    call_permutations_num += 1

    # if @call_permutations_num == 100
    #   raise
    # end

    (i..array.size - 1).each do |j|
      next if array[i].name == array[j].name

      if call_permutations_num == 500
        p ("Toutes permut #{call_permutations_num}")
        p ("Non_Valid permut #{non_valid_permutations}")
        p ("Draws #{permut_num}")
      end

      array[i], array[j] = array[j], array[i]
      p "i = #{i} - #{array[i].name} , j = #{j} - #{array[j].name}"
      array.each { |team| p "- #{team.name}" }

      # p i if i.even?
      # test match validity only if i is odd, we just want to test the couples.
      # example : if array [A,B,C,D], we want to test A&B and C&D validity, not B&C
      # return true if i.even?
      # p "i => #{i}"
      # array.each { |team| p "- #{team.name}" }
      # last_match = [array[i - 1], array[i]]
      # first_team = last_match[0]
      # second_team = last_match[1]

      permutations(array, i + 1)
      # if valid_matches?(first_team, second_team, i)
      #   #  p "i => valid"
      #   #  p "array.size = #{array.size}"
      #   raise if i == 1
      #   if i == array.size - 1

      #     p "i = array.size -1 "
      #     @permut_num += 1
      #     p @permut_num.to_s
      #     p ("Toutes permut #{@call_permutations_num}")
      #     p ("Non_Valid permut #{@non_valid_permutations}")
      #     p ("Draws #{@permut_num}")
      #     array.each { |team| p "- #{team.name}" }
      #     # array contains a draw
      #     draw_creation(array)
      #   end
      #   raise
      #   permutations(array, i + 1)
      # else
      #   p "ICIIIIIII--------------"
      #   @non_valid_permutations += 1
      # end
      # p "sortie avec i: #{i}"
      # puts "exited recursive calls"
      array[i], array[j] = array[j], array[i]
      # puts "array after the second swap: #{array}"
    end
  end

  def self.valid_matches?(first_team, second_team, teams1, teams2, i = 2) # array, i)
    return false unless teams1.include?(first_team)
    return false unless teams2.include?(second_team)

    # Are first and second teams from the different countries?
    return false if first_team.country == second_team.country

    # Are first and second teams from different groups?
    team1_group = @groups.where('team1_id =?', first_team.id).or(@groups.where('team2_id =?', first_team.id))
    team2_group = @groups.where('team1_id =?', second_team.id).or(@groups.where('team2_id =?', second_team.id))

    return false if team1_group.ids == team2_group.ids

    true
  end

  def self.draws_creation(uniques_draws, tournament)
    names = %w(A B C D E F G H)
    uniques_draws.each do |unique_draw|
      draw = Draw.create(tournament_id: tournament.id)
      name_ind = 0
      unique_draw.each_with_index do |match, name_ind|
        name = names[name_ind]
        # name_ind += 1
        p Match.create(draw_id: draw.id, team1_id: match[0].id, team2_id: match[1].id, name: name )
      end
    end
  end

# -----------------------------------
  def self.matching(teams1, teams2) # alternative to permutation by iterating in array of teams
    teams1.each do |team1|
      teams2.each do |team2|
        if valid_matches?(team1, team2, teams1, teams2)
          p team1, team2
        end
      end
    end
  end

  def self.combining(teams, teams1, teams2)
    # ressources https://tchryssos.medium.com/array-combinations-and-permutations-f9599ac5d403
    # create array with all combinations
    all_matches = teams.combination(2).to_a
    # allCombinations.each {|combination| p "#{combination[0].name} - #{combination[1].name}"}
    # eliminate forbidden combinations, create array with all matches
    allowed_matches = all_matches.select { |match| valid_matches?(match[0], match[1],teams1, teams2) }
    p "Allowed combinations :limit => size #By default SQL String limit 255 character 
      #Ex:- :limit => 40"
    allowed_matches.each {|match| p "#{match[0].name} - #{match[1].name}"}
    # create draws
    # Create all combinaisons of "combinaison" with allowedCombinations.combinaison(n) where n is the number of matches per draw
    # n = number of groups in the tournament 
    n = @groups.count
    p "n = #{n}"
    return uniques_draws = draws_maker_v3(allowed_matches, n,teams1)
    # Print
    # @all_draws.each_with_index do |draw, ind|
    #   p "-----Draw n°#{ind}"
    #   draw.each_with_index do |match, ind|
    #     p "#{match[0].name} - #{match[1].name} "
    #   end
    # end
    # Print end
  end

  def self.find_uniques_draws(all_draws)
      uniques_draws = all_draws.select do |draw|
      # draw.flatten.count
      # draw.flatten.uniq.count
      draw.flatten.count == draw.flatten.uniq.count
    end
    return uniques_draws
  end

  def self.select_first_team(all_draws, teams1)
    draws_good_first_team = all_draws.select do |draw|
      results = draw.each_with_index.map do |match, ind|
      match[0] == teams1[ind]
      end
      results.all?{|result| result == true}
    end
    return draws_good_first_team
  end
  

  def self.draws_maker_v3(allowed_matches, n, teams1)
    p "----------- draws_maker_v3 with draw_to_create:"
    all_draws = allowed_matches.combination(n).to_a
    p "all_draws count #{all_draws.count}"
    draws_good_first_team = select_first_team(all_draws, teams1)
    uniques_draws = find_uniques_draws(draws_good_first_team)
    p "---------@uniques_draws count #{uniques_draws.count}"
    uniques_draws.first(100).each_with_index do |draw, ind|
      p "******* Draw n° #{ind} ********"
      # draw.each do |match|
      #   p "#{match[0].name} - #{match[1].name}"
      # end
    end
    return uniques_draws
  end
end
# nb_equipes_voulues = 3

# teams = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map { |i| i.to_s }
# matches =  teams.combination(2).to_a # ok
# draws = matches.combination(3).to_a
# p "draws #{draws.count}"
# uniques_draws = draws.select do |draw|
#   draw.flatten.count
#   draw.flatten.uniq.count
#   draw.flatten.count == draw.flatten.uniq.count
# end

# # draws = letters.combination(nb_lettres_voulues).to_a
# uniques_draws.each do |draw|
#   draw.each do |match|
#     p match
#   end
# end
# p "all good draws count #{uniques_draws.count}"

