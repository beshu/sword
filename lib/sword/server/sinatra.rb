module Sword
  module Server
    module Sinatra
      def run!(options = {})
        set options
        handler         = detect_rack_handler
        handler_name    = handler.name.gsub(/.*::/, '')
        server_settings = settings.respond_to?(:server_settings) ? settings.server_settings : {}
        handler.run self, server_settings.merge(:Port => port, :Host => bind).merge(silent_webrick) do |server|
          unless handler_name =~ /cgi/i
            puts ">> Sword #{Sword::VERSION}/#{handler_name} at your service!\n" \
            ">> http://#{bind}:#{port} to see your project.\n" \
            ">> CTRL+C to stop."
          end
          [:INT, :TERM].each { |sig| trap(sig) { quit!(server, handler_name) } }
          server.threaded = settings.threaded if server.respond_to? :threaded=
          server.silent = true if server.respond_to? :silent= and not Environment.aloud
          set :running, true
          yield server if block_given?
        end
      rescue Errno::EADDRINUSE, RuntimeError
        puts ">> Port is in use. Another instance of Sword running?"
      end
      
      def quit!(server, handler_name)
        puts "\n" unless handler_name =~/cgi/i
        # Use Thin's hard #stop! if available, otherwise just #stop.
        server.respond_to?(:stop!) ? server.stop! : server.stop
      end

      # Silents WEBrick server (platform-specific)
      # @return [Hash] hash with settings required to silent him
      def silent_webrick
        return {} if not defined? WEBrick or Environment.aloud
        null = System::WINDOWS ? 'NUL' : '/dev/null'
        {:AccessLog => [], :Logger => WEBrick::Log::new(null, 7)}
      end
    end
  end
end
