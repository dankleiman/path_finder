require 'pry'

def path_finder(value, structure, path = [])
  if structure.include?(value)
    if structure.respond_to?(:each)
      structure.each do |element|
        if element == value
          # correct_branch = true
          path << structure.index(element)
          path << true
        else
          # path << false
          path_finder(value, element, path)
        end
      end
    else
      if structure == value
        path << "We got here on 16"
        path << true
      else
        # path << "We got here on 20"
        # path << false
      end
    end
  else
    if structure.respond_to?(:each)
        structure.each do |element|
          path = path_finder(value, element, path)
          if path.last == true
            path.insert(0, structure.index(element))
          end
        end
    else
     # path << false
    end
  end
  path
end

# favorite_movies = [[['title','The Big Lebowski'], ['year_released', '1998'], ['director', 'Joel Coen']],
#   [['title', 'The Shining'],['year_released', '1980'], ['director', 'Stanley Kubrick']],
#   [['title', 'Troll 2'],['year_released', '1990'], ['director', 'Claudio Fragasso']]]

favorite_movies = [['title','The Big Lebowski'], ['year_released', '1998'], ['director', 'Joel Coen']]
# favorite_movies = 'apple pie'

puts path_finder('The Big Lebowski', favorite_movies).inspect
