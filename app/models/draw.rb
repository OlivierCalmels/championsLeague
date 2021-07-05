class Draw < ApplicationRecord
  belongs_to :tournament
  has_many :matches

  def self.destroy_draws(tournament)
    p draws = Draw.where(tournament_id: tournament.id) # params[:tournament_id])
    draws.each do |draw|
    p matches = Match.where(draw_id: draw.id)
    # p matches.destroy_all
    # p draw.destroy
    end
  end

  def self.draws_maker(tournament)
    @tournament = Tournament.find(tournament.id) #params[:tournament_id])
    # destroy_draws(@tournament)
    @groups = Group.where(tournament_id: @tournament.id)
    @teams1 = []
    @teams2 = []
    @groups.each do |group|
      @teams1 << group.team1
      @teams2 << group.team2
    end

    @teams = @teams1 + @teams2

    # p 'All @teams:'
    # @teams.each { |team| p "- #{team.name}" }

    p 'permut:'
    @permut_num = 0 # num of valid permutations => draws
    @call_permutations_num = 0 # num of calling for permutations def
    @non_valid_permutations = 0 # Non_Valid permuts 

    start = Time.now
    permutations(@teams) # [1,2,3,4,5])
    p start
    p Time.now
    p "temps = #{Time.now - start} s"
    p "nb de permut: #{@call_permutations_num}"
    p ("Toutes permut #{@call_permutations_num}")
    p ("Non_Valid permut #{@non_valid_permutations}")
    p ("Draws #{@permut_num}")
    # @draws = @teams.permutation.to_a
    p '--------------------'
    p 'finished!'
    p '--------------------'
  end

  def self.permutations(array, i = 0)
    # puts "this is i at the beginning: #{i}, this is the array size: #{array.size}"
    # p array if i == array.size
    @call_permutations_num += 1

    # if @call_permutations_num == 100
    #   raise
    # end

    (i..array.size - 1).each do |j|
      if @call_permutations_num == 500
        p ("Toutes permut #{@call_permutations_num}")
        p ("Non_Valid permut #{@non_valid_permutations}")
        p ("Draws #{@permut_num}")
      end

      array[i], array[j] = array[j], array[i]
      # puts "this is the array after the swap: #{array}"
      # p "entrée avec i: #{i}"
      # p "array[0] = #{array[0]}"

      # p i if i.even?
      # test match validity only if i is odd, we just want to test the couples.
      # example : if array [A,B,C,D], we want to test A&B and C&D validity, not B&C
      # return true if i.even?
      # p "i => #{i}"
      # array.each { |team| p "- #{team.name}" }
      if valid_matches?(array, i)
        #  p "i => valid"
        #  p "array.size = #{array.size}"
        if i == array.size - 1
          p "i = array.size -1 "
          @permut_num += 1
          p @permut_num.to_s
          p ("Toutes permut #{@call_permutations_num}")
          p ("Non_Valid permut #{@non_valid_permutations}")
          p ("Draws #{@permut_num}")
          array.each { |team| p "- #{team.name}" }
          # array contains a draw
          draw_creation(array)

        end
        permutations(array, i + 1)
      else
        p "ICIIIIIII--------------"
        @non_valid_permutations += 1
      end
      # p "sortie avec i: #{i}"
      # puts "exited recursive calls"
      array[i], array[j] = array[j], array[i]
      # puts "array after the second swap: #{array}"
    end
  end

  def self.valid_matches?(array, i)
    return true if i.even?

    last_match = [array[i - 1], array[i]]
    first_team = last_match[0]
    second_team = last_match[1]

    return false unless @teams1.include?(first_team)
    return false unless @teams2.include?(second_team)

    # Are first and second teams from the different countries?
    return false if first_team.country == second_team.country

    # Are first and second teams from different groups?
    team1_group = @groups.where(team1_id: first_team.id).or(@groups.where(team2_id: first_team.id))
    team2_group = @groups.where(team1_id: second_team.id).or(@groups.where(team2_id: second_team.id))

    return false if team1_group.ids == team2_group.ids

    true
  end

  def self.draw_creation(array)
    draw = Draw.create(tournament_id: @tournament.id)
    name_ind = 0
    names = %w(A B C D E F G)
    array.each_slice(2) do |pair|
      name = names[name_ind]
      name_ind += 1
      p Match.create(draw_id: draw.id, team1_id: pair[0].id, team2_id: pair[1].id, name: name )
    end
  end
end
