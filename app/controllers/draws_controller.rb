class DrawsController < ApplicationController

attr_accessor :draws_maker

  def index
    @tournament = Tournament.find(params[:tournament_id])
    @draws_ar = Draw.where(tournament_id: @tournament.id)
    @draws = {}
    draws_maker
    @draws_ar.each do |draw|
      matches = Match.where(draw_id: Draw.find(draw.id))
      @draws[draw] = matches
    end
  end

  
  def draws_maker
    @tournament = Tournament.find(params[:tournament_id])
    @groups = Group.where(tournament_id: @tournament.id)
    @teams1 = []
    @teams2 = []
    @groups.each do |group|
      @teams1 << group.team1
      @teams2 << group.team2
    end

    @teams = @teams1 + @teams2

    p "All @teams:"
    @teams.each{ |team| p "- #{team.name}" }

    p "permut:"
    @permut_num = 0
    @call_permutations_num = 0
    start = Time.now
    permutations(@teams) # [1,2,3,4,5])
    p start
    p Time.now
    p "temps = #{Time.now - start} s"
    p "nb de permut: #{@call_permutations_num}"
    # @draws = @teams.permutation.to_a 
    p "--------------------"
    p "finished!"
  p "--------------------"
  end

  def permutations(array, i=0)
    # puts "this is i at the beginning: #{i}, this is the array size: #{array.size}"
    # p array if i == array.size
    @call_permutations_num += 1

    if @call_permutations_num == 10000
      raise
    end

    if i == array.size
      @permut_num += 1
      # p "#{@permut_num} - #{array}"
    end

    (i..array.size-1).each do |j|

      array[i], array[j] = array[j], array[i]
      # puts "this is the array after the swap: #{array}"

      # p "entrée avec i: #{i}"
      # p "array[0] = #{array[0]}"
      if valid_matches?(array, i)
        permutations(array, i + 1)
      else
        # p "ICIIIIIII--------------"
      end
      # p "sortie avec i: #{i}"
      # puts "exited recursive calls"
      array[i], array[j] = array[j], array[i]
      # puts "array after the second swap: #{array}"
    end
  end

  def valid_matches?(array, i)
    return true if i.even?

    last_match = [array[i-1], array[i]]
    first_team = last_match[0]
    second_team = last_match[1]

    p "Last match: #{first_team.name} vs #{second_team.name}"
    
    # Is first team a team1 ?
    return false unless @teams1.include?(first_team)
    # Is second team a team2 ?
    return false unless @teams2.include?(second_team)
    p @teams1.include?(first_team)
    p @teams2.include?(second_team)

    # Are first and second teams from the different countries?
    return false if first_team.country == second_team.country
    p "#{first_team.name} is from #{first_team.country}"
    p "#{second_team.name} is from #{second_team.country}"

    # Are first and second teams from different groups
    team1_group = @groups.where(team1_id: first_team.id)
    team2_group = @groups.where(team2_id: second_team.id)

    p team1_group == team2_group
    if team1_group == team2_group
      p "#{first_team.name} is from #{team1_group}"
      p "#{second_team.name} is from #{team2_group}"
      raise
    else
      p "#{first_team.name} is from #{team1_group}"
      p "#{second_team.name} is from #{team2_group}"
      raise
    end

    return true
  end
end
