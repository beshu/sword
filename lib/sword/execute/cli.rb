require 'sword'

module Sword
  module Execute
    # Sword command line interface
    # @api private
    class CLI
      def initialize(arguments = ARGV, width = 25, &block)
        @parser = Parser.new(arguments, 25, &block)
        Environment.CLI = true
      end

      def run
        parse_arguments
        parse_lists
        require_gems
        daemonize if Environment.daemonize
        #redirect_stderr if Environment.log
        change_directory unless Environment.here
        open if Environment.open
        run_server
        delete_pid if Environment.pid
      end

      def daemonize
        Process.daemon(true)
      end

      def open
        Thread.new do
          sleep 0.75
          system "open http://localhost:#{Environment.port}"
        end
      end

      def parse_arguments
        @parser.parse
      end

      def parse_lists
        require 'sword/execute/lists'
        Lists.load
      end

      def require_gems
        require 'sword/execute/gems'
        Gems.require_list(Environment.gems)
      end

      def change_directory
        Dir.chdir Environment.directory
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
