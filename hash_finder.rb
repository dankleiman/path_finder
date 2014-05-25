require 'pry'

#####################################################
# Given a value and a nested hash,      #
# returns the position in the hash strucure,       #
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
      #test each element of the array
      structure.each do |element|
        path << i
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
      return path
    end
  end
 path
end


def path_cleanup(raw_path)
  clean_path = ""
  true_index = raw_path.index(true)
  end_point = raw_path.length - 1
  raw_path.slice!(true_index..end_point)
  raw_path.each do |marker|
    clean_path += "[#{marker}]"
  end
  clean_path
end



favorite_movies = { title: 'The Big Lebowski', year_released: 1998, director: 'Joel Coen', imdb_rating: 8.2 },

raw_path = path_finder('The Big Lebowski', favorite_movies)
puts "Enter this path to access your element: favorite_movies#{path_cleanup(raw_path)}"
