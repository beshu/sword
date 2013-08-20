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
        parse @styles, '/*.css', Frameworks.compass
      end

      def parse_scripts
        parse @scripts, '/*.js'
      end

      def parse_templates
        p @templates
        parse @templates, '/*/?' do |page|
          HTML.each { |extension| return erb File.read(file = "#{page}.#{extension}") if File.exists? file }
          raise NotFound if page =~ /\/index$/ or not defined? env
          call env.merge({'PATH_INFO' => "/#{page}/index"})
        end
      end
    end
  end
end