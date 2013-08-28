module Sword
  module Server
    module Templates
      HTML = %w[html htm xhtml xht dhtml dhtm]

      # Generate instance variables containing parsed versions of YAML engine lists.
      # Variable names are identical to file names.
      #
      # @note
      #   Format is as follows:
      #   string is both engine method and the only extension,
      #   hash is the key is an engine method and the value is an array of extensions
      def inject_template_variables_first
        Environment.templates.each do |engine, rules|
          instance_variable_set('@' << engine, rules)
        end
      end

      def inject_styles
        parse @styles, 'css', '/*.css'
      end

      def inject_scripts
        parse @scripts, 'js', '/*.js'
      end

      def inject_html
        divided = HTML * '|'
        get(/(.+?)\.(#{divided})/) do |route, _|
          debugln "Redirecting #{env['PATH_INFO']} to #{route}..."
          call env.merge 'PATH_INFO' => route
        end
      end

      def inject_templates_last
        parse @templates, 'html', '/*/?' do |app, page, env|
          files = HTML.map { |extension| "#{Environment.directory}/#{page}.#{extension}" }
          file = files.find { |f| File.exists? f }
          if file
            sdebugln "Sending #{file} page..."
            app.content_type 'text/html'
            app.erb File.read(file)
          else
            raise Application::NotFoundError, "Can't find #{page} page, " \
            "tried every engine & HTML extension in #{Environment.directory}" if page =~ /\/index$/
            call env.merge({'PATH_INFO' => "/#{page}/index"})
          end
        end
      end
    end
  end
end
