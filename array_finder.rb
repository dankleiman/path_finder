#Given a data structure and a value,
#return the single_branch that accesses that value
require 'pry'

def path_finder(value, structure, total_branches=[], single_branch=[])
  # binding.pry
  total_branches << single_branch
    if value == structure
      puts "TRUTH"
      puts "From element: single_branch, #{single_branch} total_branches, #{total_branches}"
      return single_branch
    else
      if structure.respond_to?(:each)
        # binding.pry
        structure.each do |element|
          # binding.pry
          if element == value
            puts "TRUTH"
            single_branch << structure.index(element)
            single_branch << true
            puts "From element: single_branch, #{single_branch} total_branches, #{total_branches}"
            return single_branch
          elsif element.respond_to?(:each)
              single_branch << path_finder(value, element, total_branches, single_branch)
          else
            single_branch << structure.index(element)
          end
        end
      # elsif structure == value
      #   puts "TRUTH"
      #   single_branch << value
      #   puts "From structure: single_branch, #{single_branch} total_branches, #{total_branches}"
      #   return single_branch
      else
        # binding.pry
        single_branch << false
        puts "From else on 37: #{single_branch}"
        return single_branch
      end
    end
end


favorite_movies = [[['title','The Big Lebowski'], ['year_released', 1998], ['director', 'Joel Coen']],
  [['title', 'The Shining'],['year_released', 1980], ['director', 'Stanley Kubrick']],
  [['title', 'Troll 2'],['year_released', 1990], ['director', 'Claudio Fragasso']]]

path_finder(1998, favorite_movies)
