module Sword::Helpers
  def render(template, *path)
    template = path.unshift(template) * '/' unless path.empty?
    template = Dir["#{template}.*"].first
    template =~ /(html?|css)$/ ? File.read(template) : Tilt.new(template).render(self)
  end

  # Backwards compatability with #sass, #slim, etc. methods
  #
  # @note Doesn't comply with Sword 1.x #stylus method: #styl method should be used instead
  # @deprecated in Sword 2.x it is better to use more powerful #render method
  def method_missing(method, *args)
    Tilt[method] ? Tilt.new(args * '/' << ".#{method}").render(self) : super
  end

  # TODO: Google fonts helper
  def font(options) end

  def jquery(version = '1.10.2')
    script "ajax.googleapis.com/ajax/libs/jquery/#{version}/jquery.min.js"
  end

  def fotorama(version = '4.4.9')
    fotorama_css(version) << fotorama_js(version)
  end

  def fotorama_js(version = '4.4.9')
    script "fotorama.s3.amazonaws.com/#{version}/fotorama.js"
  end

  def fotorama_css(version = '4.4.9')
    stylesheet "fotorama.s3.amazonaws.com/#{version}/fotorama.css"
  end

  private

  def stylesheet(href)
    "<link href=\"//#{href}\" rel=\"stylesheet\"/>"
  end

  def script(src)
    "<script src=\"//#{src}\"></script>"
  end
end
