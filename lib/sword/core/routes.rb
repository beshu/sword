module Sword
  module Core
    module Routes
      HTML = %w[html htm xhtml xht dhtml dhtm]
      
      def routes
        methods.delete_if { |m| not m.to_s.start_with? 'inject_' }.each { |m| send m } 
      end

      def inject_error
        error do
          @error = env['sinatra.error']
          erb :error, :views => LIBRARY
        end
      end

      def inject_favicon
        get '/favicon.ico' do
          send_file "#{LIBRARY}/favicon.ico"
        end
      end

      def inject_index
        get '/' do
          # Call /index, the same shit
          # TODO: for any level
          call env.merge 'PATH_INFO' => '/index'
        end
      end

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
        parse @styles, '/*.css', Boot::Loader.load_compass
      end

      def parse_scripts
        parse @scripts, '/*.js'
      end

      def parse_templates
        parse @templates, '/*/?' do |page|
          HTML.each { |extension| return erb File.read(file = "#{page}.#{extension}") if File.exists? file }
          raise NotFound if page =~ /\/index$/ or not defined? env
          call env.merge({'PATH_INFO' => "/#{page}/index"})
        end
      end
    end
  end
end
