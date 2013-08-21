require 'sinatra/base'

module Sword
  module Server
    class Application < Sinatra::Base
      NotFoundError = Class.new StandardError
      extend Debugger

      class << self
        if Environment.CLI
          def run!(options = {})
            set options
            handler         = detect_rack_handler
            handler_name    = handler.name.gsub(/.*::/, '')
            server_settings = settings.respond_to?(:server_settings) ? settings.server_settings : {}
            handler.run self, server_settings.merge(:Port => port, :Host => bind) do |server|
              unless handler_name =~ /cgi/i
                $stderr.puts "== Sword #{Sword::VERSION} at your service " +
                "on #{port} for #{environment} with backup from #{handler_name}"
              end
              [:INT, :TERM].each { |sig| trap(sig) { quit!(server, handler_name) } }
              server.threaded = settings.threaded if server.respond_to? :threaded=
              set :running, true
              yield server if block_given?
            end
          rescue Errno::EADDRINUSE, RuntimeError
            $stderr.puts "== Port is in use. Is Sword already running?"
          end

          def quit!(server, handler_name)
            $stderr.puts "\n" unless handler_name =~/cgi/i
            # Use Thin's hard #stop! if available, otherwise just #stop.
            server.respond_to?(:stop!) ? server.stop! : server.stop
          end
        end

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
          get route do |name|
            layout = Dir[File.dirname(name) << '/layout.*'].first
            options.merge!({:layout => layout ? layout.sub(/\.\w+$/, '').to_sym : false})
            engine = find_engine(list, name, options)
            return engine if engine
            return block_given? ? yield(self, name, env) : raise(NotFoundError)
          end
        end

        # Silents WEBrick server (platform-specific)
        # @return [Hash] hash with settings required to silent him
        # def silent_webrick
        #   return {} if @debug or not defined? WEBrick
        #   null = WINDOWS ? 'NUL' : '/dev/null'
        #   {:AccessLog => [], :Logger => WEBrick::Log::new(null, 7)}
        # end
      end

      extend Injector
      load_settings
    end
  end
end
