module Sword
  module Server
    module Plugins
      def inject_slim
        configure do
          set :slim, :pretty => true unless Environment.compress
        end
      end

      def inject_compass
        return unless defined? Compass
        configure do
          Compass.configuration do |c|
            c.output_style = Environment.compress ? :compressed : :nested
            c.line_comments = false
            c.relative_assets = true
            c.cache = Environment.cache? ? true : false
            c.sass_dir = '.'
            c.images_dir = c.sass_dir
            c.http_images_path = c.sass_dir
            c.http_path = '/'
            c.http_stylesheets_path = c.http_path
          end

          set :sass, Compass.sass_engine_options
          set :scss, Compass.sass_engine_options
        end
      end
    end
  end
end