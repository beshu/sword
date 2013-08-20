module Sword
  module Server
    module Frameworks
      def self.compass
        return {} unless defined? Compass
        Compass.configuration do |c|
          if Environment.output_style
            c.output_style = Environment.output_style
          else
            c.output_style = Environment.compress ? :compressed : :nested
          end

          c.line_comments = Environment.line_comments ? true : false
          c.relative_assets = true
          c.cache = Environment.production? ? true : false
          c.sass_dir = '.'
          c.images_dir = c.sass_dir
          c.http_images_path = c.sass_dir
          c.http_path = '/'
          c.http_stylesheets_path = c.http_path
        end
        
        Compass.sass_engine_options
      end
    end
  end
end