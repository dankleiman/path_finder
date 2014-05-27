require 'pry'

#####################################################
# Given a value and a compound data structure,      #
# returns the position in the strucure,       #
# formatted so you can referrence it in your code   #
#####################################################

def path_finder(value, structure, path = [], paths=[])
  #i tracks the index of the current array
  i = 0
  if value == structure
    path << true
    paths << path.dup
    path.pop
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
            paths << path.dup
            # binding.pry
            while path.include?(i)
              path.pop
            end
          else
            paths = path_finder(value, element, path, paths)
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
            paths << path.dup
            while path.include?(":#{element_key}")
              path.pop
            end
            while path.include?("\"#{element_key}\"")
              path.pop
            end
          else
            paths = path_finder(value, element_value, path, paths)
            if !path.include?(true)
              #if path comes back from a false branch, remove the last part
              path.pop
            end
          end
        end
      end
    else
      return paths
    end
  end
 paths
end

def path_cleanup(raw_path)
  clean_path = ""
  raw_path.each do |each_array|
    each_array.pop
    each_array.each do |marker|
      clean_path += "[#{marker}]"
    end
    clean_path += "\n"
  end
  clean_path
end

favorite_movies = [{title: 'ET', year: '1986', stuff: {cast: ['nobody', 'nobody', 'nobody', 'nobody', 'ET'], name: 'ET'}}, {title: 'BT', year: '1990', name: 'ET'}]
raw_path = path_finder('ET', favorite_movies)

puts path_cleanup(raw_path)
