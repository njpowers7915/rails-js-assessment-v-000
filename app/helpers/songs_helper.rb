module SongsHelper

  def slug(input)
    slug = input.downcase.strip.gsub(/[\s-]/, '_')
  end

  def slug_to_name(input)
    name = input.gsub('_', ' ')
    final = name.split.map(&:capitalize).join(' ')
  end

end
