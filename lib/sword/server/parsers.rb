module Sword
  module Server
    module Parsers
      HTML = %w[html htm xhtml xht dhtml dhtm]

      # Handles a request and tries to find a template engine capable to parse the template
      # 
      # @param list [String] instance variable containing engine list from `/engines` folder
      # @param route [String] ordinary route pattern (should be like `/*.css`)
      # @param options [Hash] hash of options to give to the found template engine
      # @param &block [Block] block to run if nothing is found
      # @raise [NotFoundError] if no template engine was found and block was not specified
      # @yield '*' from the route pattern
      def parse(list, route, options = {}, &block)
        get route do |name|
          layout = Dir[File.dirname(name) << '/layout.*'].first
          options.merge!({:layout => layout ? layout.sub(/\.\w+$/, '').to_sym : false})
          engine = find_engine(list, name, options)
          return engine if engine
          return block_given? ? yield(self, name, env) : raise(NotFoundError)
        end
      end

      def inject_styles
        parse @styles, '/*.css'
      end

      def inject_scripts
        parse @scripts, '/*.js'
      end

      def inject_html
        divided = HTML * '|'
        get(/(.+?)\.(#{divided})/) do |route, _|
          call env.merge 'PATH_INFO' => route
        end
      end

      def inject_templates
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