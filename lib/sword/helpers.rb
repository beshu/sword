module Sword::Helpers
  def render(template, *path)
    template = path.unshift(template) * '/' unless path.empty?
    template = Dir[template << '.*'].first
    template =~ /(html?|css)$/ ? File.read(template) : Tilt.new(template).render(self)
  end
end
