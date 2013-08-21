module Sword
  module Server
    module Parsers
      HTML = %w[html htm xhtml xht dhtml dhtm]

      def inject_parsers
        parse_styles
        parse_scripts
        synonymize_html
        parse_templates
      end

      def synonymize_html
        get(/(.+?)\.(#{ HTML * '|' })/) do |route, _|
          call env.merge 'PATH_INFO' => route
        end
      end

      def parse_styles
        parse @styles, '/*.css'
      end

      def parse_scripts
        parse @scripts, '/*.js'
      end

      def parse_templates
        parse @templates, '/*/?' do |app, page, env|
          files = HTML.dup.map { |extension| "#{Environment.directory}/#{page}.#{extension}" }
          file = files.find { |f| File.exists? f }
          if file
            app.erb File.read(file)
          else
            raise Application::NotFoundError, "Can't find #{page}, " \
            "tried every engine & HTML extension in #{Environment.directory}" if page =~ /\/index$/
            call env.merge({'PATH_INFO' => "/#{page}/index"})
          end
        end
      end
    end
  end
end