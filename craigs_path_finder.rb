require 'pry'

def path_finder(value, structure, path = [], paths=[])
  i = 0
  if value == structure
    path << true
    paths << path.dup
    path.pop
  end
  if !path.include?(true)
    if structure.respond_to?(:each)
      if structure.class <= Array
        structure.each do |element|
          path << i
          if element.class == String && value.class == String
            if element =~ /\b#{Regexp.quote(value)}\b/i
              path << true
              paths << path.dup
              path.pop(2)
            else
              path.pop
            end
          elsif element == value
            path << true
            paths << path.dup
            path.pop(2)
          else
            paths = path_finder(value, element, path, paths)
            if !path.include?(true)
              path.pop
            end
          end
          i+=1
        end
      else
        structure.each do |element_key, element_value|
          if element_key.class == Symbol
            path << ":#{element_key}"
          else
            path << "\"#{element_key}\""
          end
          if element_value.class == String && value.class == String
            if element_value =~ /\b#{Regexp.quote(value)}\b/i
              path << true
              paths << path.dup
              path.pop(2)
            else
              path.pop
            end
          elsif element_value == value || element_key == value
            path << true
            paths << path.dup
            path.pop(2)
          else
            paths = path_finder(value, element_value, path, paths)
            if !path.include?(true)
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
