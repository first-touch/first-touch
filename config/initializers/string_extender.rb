class String
  def normalize
    normalized_string = self || ''
    normalized_string.gsub(/[^0-9a-z]/i, '').downcase.strip
  end
end
