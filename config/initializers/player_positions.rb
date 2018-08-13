module FirstTouch
  PLAYING_POSITIONS = YAML.load_file(
    Rails.root.join('config', 'playing_positions.yml')
  )
end
