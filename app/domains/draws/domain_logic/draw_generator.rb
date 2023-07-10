# frozen_string_literal: true

module Draws
  module DomainLogic
    class DrawGenerator

      def initialize; end

      def call(tournament:)
        teams = team_for(tournament: tournament)
        generate_draws(teams)
      end

      def team_for(tournament:)
        groups = tournament.groups
        teams = groups.map do |group|
          [
            DomainLogic::Team.from_model(team: group.team1, group_id: group.id, placement: 'first'),
            DomainLogic::Team.from_model(team: group.team2, group_id: group.id, placement: 'second')
          ]
        end
        # teams.flatten
      end

      def generate_draws(teams)
        start_time = DateTime.now
        time = start_time
        teams1 = teams.map{|teams_by_group| teams_by_group[0] }
        teams2 = teams.map{|teams_by_group| teams_by_group[1] }
        # teams2 = (1..8).to_a
        
        # number_of_teams=teams.count
        number_of_matches_per_draw = teams2.count
        # teams_per_match = 2
        # binding.pry

        # all_draws = teams
        #               .permutation
                      # .map { |permutation| permutation.each_slice(teams_per_match) }
                      # .map do |draw|
                      #   draw.map do |match|
                      #     match.sort_by(&:database_id)
                      #   end.sort! do |match1, match2|
                      #     match1.first.database_id <=> match2.first.database_id
                      #   end
                      # end
                      # .uniq   
                    # [[[1,2], [3,4]], [[1,3], [2,4]]]  
                      
        # Les équipes 1 sont fixées
        # Seules des équipes 2 bougent
        teams2_permutations = teams2.to_a.permutation.to_a

        teams2_permutations = remove_first_permutations(teams2_permutations,number_of_matches_per_draw )

        permutations = []
        valid_draws = teams2_permutations.each.with_index do |team2_permutation, permut_number|
          permutation = []
          team2_permutation.each.with_index do |team, group|
            if team.group_id == teams1[group].group_id
              puts "Même groupe"
              # debugger
              break
            end
            if team.country == teams1[group].country
              puts "Même pays"
              # debugger
              break
            end

            # break if team.country == teams1[group].country
            permutation << [ teams1[group], team]
          end
          # debugger
          if permutation.count == number_of_matches_per_draw
            # puts "On garde permutation: #{permutation}"
            permutations << permutation
          end
          last_time = time
          time = DateTime.now
          puts "permut_number: #{permut_number}/#{teams2_permutations.count} - #{((last_time - time) * 24 * 60 * 60).to_i } "
        end
        puts "Fin de generate_draws"
        # puts "Permutations: #{permutations}"

        puts "Number of Permutations kept: #{permutations.count}"
        # binding.pry
        permutations
      end


      def remove_first_permutations(teams2_permutations, teams_count)
        # (1..(teams_count-1)).inject(:*)
        teams2_permutations.drop((1..(teams_count-1)).inject(:*))
      end


        # Ex: 4 équipes
        # teams2_permutations = (1..4).to_a.permutation.to_a 
        # [[1, 2, 3, 4],x
        # [1, 2, 4, 3],x
        # [1, 3, 2, 4],x
        # [1, 3, 4, 2],x
        # [1, 4, 2, 3],x
        # [1, 4, 3, 2],x
        # [2, 1, 3, 4],x
        # [2, 1, 4, 3],
        # [2, 3, 1, 4],x
        # [2, 3, 4, 1],
        # [2, 4, 1, 3],
        # [2, 4, 3, 1],x
        # [3, 1, 2, 4],x
        # [3, 1, 4, 2],
        # [3, 2, 1, 4],x
        # [3, 2, 4, 1],x
        # [3, 4, 1, 2],
        # [3, 4, 2, 1],
        # [4, 1, 2, 3],
        # [4, 1, 3, 2],x
        # [4, 2, 1, 3],x
        # [4, 2, 3, 1],x
        # [4, 3, 1, 2],
        # [4, 3, 2, 1]]

        # Il faut trouver comment calculer les tirages à supprimer d'office
        # La liste contient les équipes 2 uniquement
        # Les positions corrspondent aux teams1
        # A chaque fois qu'une équipe est en face de sa position, il faut supprimer le tirage

        # ex: Si l'équipe 1 est en première position (0 dans l'array),
        # il faut supprimer car une équipe1 d'un groupe ne peut rencontrer l'équipe2 du mm groupe.

        # Commencer par le min

        private

        def palier(nb)
          (1..(nb_matches-1)).inject(:*)
        end

        def paliers(nb_matches)
          (1..nb_matches).map do |num|
            palier(nb_matches) * num
          end
        end

        # n1=(nb de matchs-1)!  factoriel. ex: Si 4, n=(4-1)! n= 3*2*1
        # n2=(nb de matchs-1)! *2
        # n3=(nb de matchs-1)! *3
        # n4=(nb de matchs-1)! *4

        # 1 => Supprimer les n premiers tirages
        # ET C'EST BON

        # 2 => Supprimer les tirages entre n1 et n2
        # puis

        # 3 => laisser les Supprimer les n premiers tirages
        # n=(nb de matchs-1)! *3
        # puis

    end
  end
end
