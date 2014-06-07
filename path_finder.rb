def path_finder(search, structure, current_path = "")
  paths = []
  if search.class == String && structure.class == String
    if structure =~ /\b#{Regexp.quote(search)}\b/i
      paths << current_path
    end
  elsif search == structure
    paths << current_path
  elsif structure.class <= Array
    structure.each_with_index do |element, index|
      paths << path_finder(search, element, current_path + "[#{index}]")
    end
  elsif structure.class <= Hash
    structure.each do |key, element|
      if key.class == Symbol
        paths << path_finder(search, key, current_path + "[:#{key}]")
        paths << path_finder(search, element, current_path + "[:#{key}]")
      else
        paths << path_finder(search, key, current_path + "[\"#{key}\"]")
        paths << path_finder(search, element, current_path + "[\"#{key}\"]")
      end
    end
  else
    return []
  end
  paths.flatten
end
