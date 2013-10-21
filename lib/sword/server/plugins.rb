module Sword
  module Server
    module Plugins
      def inject_slim
        configure do
          unless Environment.compress
            set :slim, :pretty => true
          end
        end
      end

      def inject_haml
        configure do
          if Environment.compress
            set :haml, :remove_whitespace => true
          end
        end
      end

      def inject_stylus
        configure do
          if Environment.compress
            set :stylus, :compress => true
          end
        end
      end

      def inject_compass
        return unless defined? Compass
        configure do
          Compass.configuration do |c|
            c.output_style = Environment.compress ? :compressed : :nested
            c.line_comments = false
            c.relative_assets = true
            c.cache = true
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
