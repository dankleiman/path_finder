require 'pry'

#####################################################
# Given a value and a nested hash,      #
# returns the position in the hash strucure,       #
# formatted so you can referrence it in your code   #
#####################################################

def path_finder(value, structure, path = [])
  #i tracks the index of the current array
  if value == structure
    path << true
  end
  if !path.include?(true)
    # binding.pry
    if structure.respond_to?(:each)
      #test each element of the hash
      structure.each do |element_key, element_value|
        if !path.include?(true)
          #once we've captured "true", we don't need to add to the path anymore
          path << element_key
        end
        if element_value == value
          path << true
        else
          path = path_finder(value, element_value, path)
          if !path.include?(true)
            #if path comes back from a false branch, remove the last part
            path.pop
          end
        end
      end
    else
      return path
    end
  end
 path
end


def path_cleanup(raw_path)
  clean_path = ""
  raw_path.pop
  raw_path.each do |marker|
    clean_path += "[#{marker}]"
  end
  clean_path
end



favorite_movies = favorite_movies = {
  first: { title: 'The Big Lebowski', year_released: 1998, director: 'Joel Coen', imdb_rating: 8.2 },
  second:{ title: 'The Shining', year_released: 1980, director: 'Stanley Kubrick', imdb_rating: 8.5 },
  third: { title: 'Troll 2', year_released: 1990, directory: 'Claudio Fragasso', imdb_rating: 2.5 }
}

raw_path = path_finder('The Big Lebowski', favorite_movies)
puts raw_path.inspect
puts "Enter this path to access your element: favorite_movies#{path_cleanup(raw_path)}"
