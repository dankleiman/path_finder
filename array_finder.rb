require 'pry'

#####################################################
# Given a value and a multi-dimensional array,      #
# returns the position in the array strucure,       #
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



favorite_movies = [[['title','The Big Lebowski'], ['year_released', '1998'], ['director', 'Joel Coen']],
  [['title', 'The Shining'],['year_released', 1980], ['director', 'Stanley Kubrick']],
  [['title', 'Troll 2'],['year_released', '1990'], ['director', 'Claudio Fragasso']]]

# favorite_movies = [['title','The Big Lebowski'], ['year_released', '1998']]
# favorite_movies = 'apple pie'

raw_path = path_finder(1980, favorite_movies)
puts raw_path.inspect
puts "Enter this path to access your element: favorite_movies#{path_cleanup(raw_path)}"
