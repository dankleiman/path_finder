# require 'pry'

def path_finder(value, structure, current_path = "", paths=[])
  if value.class == String && structure.class == String
    if structure =~ /\b#{Regexp.quote(value)}\b/i
      paths << current_path
    end
  elsif value == structure
    paths << current_path
  elsif structure.is_a?(Array)
    structure.each_with_index do |element, index|
      paths = path_finder(value, element, current_path + "[#{index}]", paths)
    end
  elsif structure.is_a?(Hash)
    structure.each do |key, element|
      if key.class == Symbol
        paths = path_finder(value, key, current_path + "[:#{key}]", paths)
        paths = path_finder(value, element, current_path + "[:#{key}]", paths)
      else
        paths = path_finder(value, key, current_path + "['#{key}']", paths)
        paths = path_finder(value, element, current_path + "['#{key}']", paths)
      end
    end
  end
  paths
end

data = {"total"=>134, "movies"=>[{"id"=>"771304593", "title"=>"Maleficent", 'year' => 2014, "mpaa_rating"=>"PG", "runtime"=>97, "critics_consensus"=>"Angelina Jolie's magnetic performance outshines Maleficent's dazzling special effects; unfortunately, the movie around them fails to justify all that impressive effort.", "release_dates"=>{"theater"=>"2014-05-30"}, "ratings"=>{"critics_rating"=>"Rotten", "critics_score"=>50, "audience_rating"=>"Upright", "audience_score"=>76}, "synopsis"=>"\"Maleficent\" explores the untold story of Disney's most iconic villain from the classic \"Sleeping Beauty\" and the elements of her betrayal that ultimately turn her pure heart to stone. Driven by revenge and a fierce desire to protect the moors over which she presides, Maleficent cruelly places an irrevocable curse upon the human king's newborn infant Aurora. As the child grows, Aurora is caught in the middle of the seething conflict between the forest kingdom she has grown to love and the human kingdom that holds her legacy. Maleficent realizes that Aurora may hold the key to peace in the land and is forced to take drastic actions that will change both worlds forever. (c) Walt Disney Pictures", "posters"=>{"thumbnail"=>"http://content8.flixster.com/movie/11/17/67/11176742_mob.jpg", "profile"=>"http://content8.flixster.com/movie/11/17/67/11176742_pro.jpg", "detailed"=>"http://content8.flixster.com/movie/11/17/67/11176742_det.jpg", "original"=>"http://content8.flixster.com/movie/11/17/67/11176742_ori.jpg"}, "abridged_cast"=>[{"name"=>"Angelina Jolie", "id"=>"162652626", "characters"=>["Maleficent"]}, {"name"=>"Sharlto Copley", "id"=>"770674319", "characters"=>["Stefan"]}, {"name"=>"Elle Fanning", "id"=>"528361349", "characters"=>["Princess Aurora"]}, {"name"=>"Sam Riley", "id"=>"770673828", "characters"=>["Diaval"]}, {"name"=>"Imelda Staunton", "id"=>"162693364", "characters"=>["Knotgrass"]}], "alternate_ids"=>{"imdb"=>"1587310"}, "links"=>{"self"=>"http://api.rottentomatoes.com/api/public/v1.0/movies/771304593.json", "alternate"=>"http://www.rottentomatoes.com/m/maleficent_2014/", "cast"=>"http://api.rottentomatoes.com/api/public/v1.0/movies/771304593/cast.json", "clips"=>"http://api.rottentomatoes.com/api/public/v1.0/movies/771304593/clips.json", "reviews"=>"http://api.rottentomatoes.com/api/public/v1.0/movies/771304593/reviews.json", "similar"=>"http://api.rottentomatoes.com/api/public/v1.0/movies/771304593/similar.json"}}]}

raw_path = path_finder('Maleficent', data)
puts raw_path
