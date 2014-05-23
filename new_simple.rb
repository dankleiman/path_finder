require 'pry'

def path_finder(value, structure, path = [], all_branches = [])
  if structure.include?(value)
    if structure.respond_to?(:each)
      structure.each do |element|
        if element == value
          path << true
        else
          path << false
        end
      end
    else
      if structure == value
        path << true
      else
        path << false
      end
    end
  else
    if structure.respond_to?(:each)
        structure.each do |element|
          all_branches << []
          all_branches.last << path
          puts all_branches.inspect
          path_finder(value, element, path, all_branches)
        end
    else
     path << false
    end
  end
  path
end

favorite_movies = [['title','The Big Lebowski'],['year_released', "1998"]]
puts path_finder('The Big Lebowski', favorite_movies).inspect
