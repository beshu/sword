module Sword
  module Server
    module Parser
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

      def find_engine(template, name, options)
        template.each do |engine, extensions|
          extensions.each do |extension|
            return send(engine, name.to_sym, options) \
              if File.exists? "#{Environment.directory}/#{name}.#{extension}"
          end
        end
        false
      end
    end
  end
end