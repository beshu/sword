module Sword
  module Server
    module Plugins
      def plugins
        plugins = methods.delete_if { |m| not m.to_s.start_with?('plugin_') }
        plugins.each { |plugin| send plugin }
      end

      def plugin_compass
        return {} unless defined? Compass
        configure do
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

          set :sass, Compass.sass_engine_options
          set :scss, Compass.sass_engine_options
        end
      end
    end
  end
end