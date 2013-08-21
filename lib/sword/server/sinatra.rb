module Sword
  module Server
    module Sinatra
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

      # Silents WEBrick server (platform-specific)
      # @return [Hash] hash with settings required to silent him
      def silent_webrick
        return {} if @debug or not defined? WEBrick
        null = WINDOWS ? 'NUL' : '/dev/null'
        {:AccessLog => [], :Logger => WEBrick::Log::new(null, 7)}
      end
    end
  end
end