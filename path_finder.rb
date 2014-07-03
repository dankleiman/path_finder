def path_finder(value, structure, current_path = "", paths = [])

  if value.class == String && structure.class == String
    if structure =~ /\b#{Regexp.quote(value)}\b/i
      paths << current_path
    end
  elsif value == structure
    paths << current_path
  elsif structure.class <= Array
    structure.each_with_index do |element, index|
      if path_finder(value, element, current_path + "[#{index}]") != nil
        paths << path_finder(value, element, current_path + "[#{index}]")
      end
    end
  elsif structure.class <= Hash
    structure.each do |key, element|
      if key.class == Symbol
        if path_finder(value, key, current_path + "[:#{key}]") != nil
          paths << path_finder(value, key, current_path + "[:#{key}]")
        end
        if path_finder(value, element, current_path + "[:#{key}]") != nil
          paths << path_finder(value, element, current_path + "[:#{key}]")
        end
      else
        if path_finder(value, key, current_path + "['#{key}']") != nil
          paths << path_finder(value, key, current_path + "['#{key}']")
        end
        if path_finder(value, element, current_path + "['#{key}']") != nil
          paths << path_finder(value, element, current_path + "['#{key}']")
        end
      end
    end
  else
    return nil
  end
  paths.flatten
end

