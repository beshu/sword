module Sword
  module Execute
    module Steps
      def require_rubygems
        require 'rubygems' if System::OLD_RUBY
      end

      def parse_arguments
        @parser.parse
      end

      def load_templates
        require 'sword/execute/lists'
        Lists.load
      end

      def filter_templates
        require 'sword/execute/filter'
        Filter.filter
      end

      def load_gems
        require 'sword/execute/loader'
        Loader.load
      end

      def daemonize
        Process.daemon(true)
      end

      def change_directory
        Dir.chdir Environment.directory
      end

      def open_browser
        Thread.new do
          sleep 0.75
          url = "http://localhost:#{Environment.port}"
          if System::OSX
            system "open #{url}"
          else
            require 'launchy'
            Launchy.open(url) {}
          end
        end
      end

      def run_server
        require 'sword/server'
        Server::Application.inject
        Server::Application.run!
      end

      def delete_pid
        File.delete(Environment.pid)
      end
    end
  end
end
