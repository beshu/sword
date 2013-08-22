module Sword
  module Server
    module Parser
      include Debugger
      module Public
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
            options.merge! find_layout(name) unless route =~ /\/.+\..+$/
            engine = find_engine(list, name, options)
            return engine if engine
            return block_given? ? yield(self, name, env) : raise(Application::NotFoundError, \
            "Can't find #{name} using #{route} mask; no rescue block given")
          end
        end
      end

      def find_layout(name)
        debugln "Searching for a layout for #{name}..."
        layout = find_layout_file name
        until layout || name == Environment.directory
          name = File.dirname(name)
          layout = find_layout_file name
          debuglnup name
        end
        {:layout => layout ? layout.sub(/\.\w+$/, '').to_sym : false}
      end

      def find_layout_file(directory)
        Dir["#{directory}/layout.*"].first
      end

      def find_engine(template, name, options)
        template.each do |engine, extensions|
          extensions.each do |extension|
            return send(engine, name.to_sym, options) \
              if File.exists? "#{Environment.directory}/#{name}.#{extension}"
          end
        end
        false
      end

      def self.included(base)
        base.extend Public
      end
    end
  end
end