require 'pry'

#####################################################
# Given a value and a compound data structure,      #
# returns the position in the strucure,       #
# formatted so you can referrence it in your code   #
#####################################################

def path_finder(value, structure, path = [])
  #i tracks the index of the current array
  i = 0
  if value == structure
    path << true
  end
  if !path.include?(true)
    # binding.pry
    if structure.respond_to?(:each)
      if structure.class == Array
        #test each element of the array
        structure.each do |element|
          if !path.include?(true)
            path << i
          end
          if element == value
            path << true
          else
            path = path_finder(value, element, path)
            if !path.include?(true)
              #if path comes back from a false branch, remove the last part
              path.pop
            end
          end
          #before you test the next element, add 1 to track the index
          i+=1
        end
      else
         structure.each do |element_key, element_value|
          if !path.include?(true)
            #once we've captured "true", we don't need to add to the path anymore
            # binding.pry
            if element_key.class == Symbol
              path << ":#{element_key}"
            else
              path << "\"#{element_key}\""
            end
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


favorite_movies = [
  { title: 'The Big Lebowski', year_released: 1998, director: 'Joel Coen', imdb_rating: 8.2 },
  { title: 'The Shining', year_released: 1980, director: 'Stanley Kubrick', imdb_rating: 8.5 },
  { title: 'Troll 2', year_released: 1990, "director" => 'Claudio Fragasso', imdb_rating: 2.5 }
]

raw_path = path_finder('Claudio Fragasso', favorite_movies)
puts "Enter this path to access your element: favorite_movies#{path_cleanup(raw_path)}"
