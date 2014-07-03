def path_finder(value, structure, current_path = "", paths=[])

  if value == structure
    # return [current_path]
    paths << current_path
  elsif structure.is_a?(Array)
    structure.each_with_index do |element, index|
      paths = path_finder(value, element, current_path + "[#{index}]", paths)
    end
  elsif structure.is_a?(Hash)
    structure.each do |key, element|
      paths = path_finder(value, key, current_path + "[:#{key}]", paths)
      paths = path_finder(value, element, current_path + "[:#{key}]", paths)
    end
  end
  paths
end
