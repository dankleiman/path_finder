require 'pry'

def path_finder(value, structure, path = [])
  if value == structure
    path << true
    return path
  end

  if structure.include?(value)
    if structure.respond_to?(:each)
      structure.each do |element|
        if element == value
          # path << "[#{structure.index(element)}]"
          path << true
          # return true
        else
          path_finder(value, element, path)
        end
      end
    else
      if structure == value
        # path << "[#{structure.index(element)}]"
        path << true
      else
        # path << "We got here on 20"
        path << false
      end
    end
  else
    if structure.respond_to?(:each)
        structure.each do |element|
          path = path_finder(value, element, path)
          if path.last == true
            # path.insert(0, "[#{structure.index(element)}]")
          end
        end
    else
     path << false
    end
  end
  path
end

def path_cleanup(raw_path)
  clean_path = ""
  raw_path.reject!{|i| i == false || i == true}
  clean_path = raw_path.join
end





favorite_movies = [[['title','The Big Lebowski'], ['year_released', '1998'], ['director', 'Joel Coen']],
  [['title', 'The Shining'],['year_released', '1980'], ['director', 'Stanley Kubrick']],
  [['title', 'Troll 2'],['year_released', '1990'], ['director', 'Claudio Fragasso']]]

# favorite_movies = [['title','The Big Lebowski'], ['year_released', '1998']]
# favorite_movies = 'apple pie'

raw_path = path_finder('The Shining', favorite_movies)
puts raw_path.inspect
puts raw_path.length
puts favorite_movies.flatten.length
puts "Enter this path to access your element: #{path_cleanup(raw_path)}"
