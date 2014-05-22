#Given a data structure and a value,
#return the path that accesses that value
require 'pry'
def path_finder(value, structure, path="")

  if value == structure
    return path
  elsif structure.class == Array
    #array loop
    i = 0
    until path !="" do
        if structure[i] == value
          path.insert(0,"[#{i}]")
          # binding.pry
          return path
        else
          #should jump into recursion here
          path = path_finder(value, structure[i], path)
          # binding.pry
          path.insert(0,"[#{i}]")
        end
        i += 1
         # binding.pry
    end
  elsif structure.class == Hash
    #hash loop
    structure.each do |key, kvalue|
      if value == kvalue
        if key.class == Symbol
          path.insert(0, "[:#{structure.key(value)}]")
        else
          path.insert(0, "[\"#{structure.key(value)}\"]")
        end
        # binding.pry
        return path
       else
        #should jump into recursion here
        path = path_finder(value, kvalue, path)
        # binding.pry
        # if key.class == Symbol
        #   path.insert(0, "[:#{structure.key(value)}]")
        # else
        #   path.insert(0, "[\"#{structure.key(value)}\"]")
        # end
      end
    end
  else
      return path
  end
  path
end


favorite_movies = [
  { "title" => 'The Big Lebowski', year_released: 1998, director: 'Joel Coen', imdb_rating: 8.2 },
  { title: 'The Shining', year_released: 1980, director: 'Stanley Kubrick', imdb_rating: 8.5 },
  { title: 'Troll 2', year_released: 1990, directory: 'Claudio Fragasso', imdb_rating: 2.5 }
]

favorite_movies = { "title" => 'The Big Lebowski', year_released: 1998, director: 'Joel Coen', imdb_rating: 8.2 }


puts path_finder('Joel Coen', favorite_movies)
