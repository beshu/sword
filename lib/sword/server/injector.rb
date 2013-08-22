module Sword
  module Server
    module Injector
      def inject
        send_injections(find_injections)
      end

      def find_injections
        methods.delete_if { |m| not m.to_s.start_with? 'inject_' }
      end

      def send_injections(injections)
        send_remaining_injections send_first_injections(injections)
      end

      def send_first_injections(injections)
        debugln "Sending high-priority injections..."
        remaining = injections.dup
        injections.each do |i|
          if i.to_s.end_with? '_first'
            sdebugln i
            send i
            remaining.delete(i)
          end
        end
        remaining
      end

      def send_remaining_injections(injections)
        debugln "Sending remaining injections..."
        injections.each do |i|
          sdebugln i
          send i
        end
      end

      def inject_pidfile
        open(Environment.pid, 'w') { |f| f.puts Process.pid } if Environment.pid
      end

      def inject_environment
        set :show_exceptions, false unless Environment.exceptions
        set :port, Environment.port
        set :server, Environment.server if Environment.server
        set :bind, Environment.host if Environment.host
        set :lock, true if Environment.mutex
        set :views, Environment.directory # Structure-agnostic
        set :public_folder, settings.views
      end
    end
  end
end