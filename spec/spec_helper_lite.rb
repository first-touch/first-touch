def needs(path_fragment)
  full_path = File.expand_path("#{Dir.pwd}/#{path_fragment}")
  return if $LOAD_PATH.include?(full_path)
  $LOAD_PATH.unshift full_path
end
