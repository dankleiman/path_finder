def path_finder(value, structure, current_path = "")
  paths = []

  if value.class == String && structure.class == String
    if structure =~ /\b#{Regexp.quote(value)}\b/i
      return current_path
    end
  elsif value == structure
    return current_path
  elsif structure.is_a?(Array)
    structure.each_with_index do |element, index|
      paths << path_finder(value, element, current_path + "[#{index}]")
    end
  elsif structure.is_a?(Hash)
    structure.each do |key, element|
      if key.class == Symbol
        paths << path_finder(value, key, current_path + "[:#{key}]")
        paths << path_finder(value, element, current_path + "[:#{key}]")
      else
        paths << path_finder(value, key, current_path + "['#{key}']")
        paths << path_finder(value, element, current_path + "['#{key}']")
      end
    end
  end
  paths
end
