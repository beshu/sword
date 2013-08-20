begin
  require 'sinatra/base'
rescue LoadError
  require 'rubygems'
  require 'sinatra/base'
end

module Sword
  module Server
    class Application < Sinatra::Base
      NotFoundError = Class.new StandardError
      extend Debugger

      class << self
        # def run!(options = {})
        #   @debug, @silent = options[:debug], options[:silent]
        #   server_settings = settings.respond_to?(:server_settings) ? settings.server_settings : {}
        #   initialize_engines("#{LIBRARY}/engines/*.yml")

        #   detect_rack_handler.run self, server_settings.merge({:Port => options[:port], :Host => bind}).merge(silent_webrick) do |server|
        #     [:INT, :TERM].each { |s| trap(s) { quit!(server) } }
        #     print ">> Sword #{VERSION} at your service!\n" \
        #     "   http://localhost:#{options[:port]} to see your project.\n" \
        #     "   CTRL+C to stop.\n"
            
        #     specify_directory options[:directory]

        #     unless @debug
        #       server.silent = true if server.respond_to? :silent=
        #       disable :show_exceptions
        #     end

        #     server.threaded = settings.threaded if server.respond_to? :threaded
        #     set :running, true
        #     yield server if block_given?
        #   end
        # rescue Errno::EADDRINUSE, RuntimeError
        #   print "!! Port is in use. Is Sword already running?\n"
        # end

        private

        # Handles a request and tries to find a template engine capable to parse the template
        # 
        # @param list [String] instance variable containing engine list from `/engines` folder
        # @param route [String] ordinary route pattern (should be like `/*.css`)
        # @param options [Hash] hash of options to give to the found template engine
        # @param &block [Block] block to run if nothing is found
        # @raise [NotFoundError] if no template engine was found and block was not specified
        # @yield '*' from the route pattern
        def parse(list, route, options = {}, &block)
          self.get route do |name|
            engine = find_engine(list, name, options)
            return engine if engine
            block_given? ? yield(name) : raise(NotFoundError)
          end
        end

        # Stops the server (stolen from original Sinatra)
        # def quit!(server)
        #   print "\n"
        #   server.respond_to?(:stop!) ? server.stop! : server.stop
        # end

        # Silents WEBrick server (platform-specific)
        # @return [Hash] hash with settings required to silent him
        # def silent_webrick
        #   return {} if @debug or not defined? WEBrick
        #   null = WINDOWS ? 'NUL' : '/dev/null'
        #   {:AccessLog => [], :Logger => WEBrick::Log::new(null, 7)}
        # end
      end

      set :port, Environment.port
      set :views, Environment.directory # Structure-agnostic
      set :public_folder, settings.views
      
      helpers { include Helpers }
      include Templates
      extend Templates
      extend Routes
      extend Parsers
      inject
    end
  end
end
