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
        change_directory
        open
        run_server
        delete_pid
      end

      def open
        if Environment.open
          Thread.new do
            sleep 0.75
            system "open http://localhost:#{Environment.port}"
          end
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
        Gems.require_default
      end

      def change_directory
        unless Environment.nocd
          Dir.chdir Environment.directory
        end
      end

      def run_server
        require 'sword/server'
        Sword::Server::Application.run!
      end

      def delete_pid
        File.delete(Environment.pid) if Environment.pid
      end
    end
  end
end
