module Sword
  module Server
    module Injector
      SERVED_FIRST = %w[inject_index inject_favicon inject_templates]

      def inject
        injections = methods.delete_if { |m| not m.to_s.start_with? 'inject_' }
        SERVED_FIRST.each { |i| send i; injections - [i] }
        injections.reverse.each { |i| send i }
      end

      def create_pidfile
        open(Environment.pid, 'w') { |f| f.puts Process.pid }
      end

      def load_settings
        set :show_exceptions, false
        set :port, Environment.port
        set :views, Environment.directory # Structure-agnostic
        set :public_folder, settings.views

        helpers { include Helpers }
        include Templates

        extend Plugins
        extend Templates
        extend Routes
        extend Parsers

        inject
        plugins
      end
    end
  end
end