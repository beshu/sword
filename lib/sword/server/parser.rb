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
            debugln "Parsing #{env['PATH_INFO']}..."
            if engine = find_engine(list, name, options)
              sdebugln "Template compiled!"
              return engine
            end
            sdebugln "Engine has not been found, yielding or raising now..."
            return block_given? ? yield(self, name, env) : raise(Application::NotFoundError, \
            "Can't find #{name} using #{route} mask; no rescue block given")
          end
        end
      end

      def find_layout(name, extension)
        layout = nil
        sdebugln "Searching for a layout for #{name}.#{extension}..."
        until layout || name == Environment.directory
          name = File.dirname(name)
          layout = find_layout_file(name, extension)
        end
        {:layout => layout ? find_layout_symbol(layout) : false}
      end

      def find_layout_symbol(layout)
        layout.sub(/\.\w+$/, '').to_sym
      end

      def find_layout_file(directory, extension)
        layout = "#{directory}/layout.#{extension}"
        sdebugln '   ' << layout
        Dir[layout].first
      end

      def find_engine(template, name, options)
        template.each do |engine, extensions|
          extensions.each do |extension|
            if File.exists? "#{Environment.directory}/#{name}.#{extension}"
              options.merge! find_layout(name, extension) if Environment.layouts.include?(extension)
              sdebugln "Sending #{name} to #{engine}..."
              return send(engine, name.to_sym, options)
            end 
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
