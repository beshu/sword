require 'sword'

module Sword
  module Execute
    # Sword command line interface
    # @api private
    class CLI
      def initialize(arguments = ARGV, width = 25, &block)
        @parser = Parser.new(arguments, 25, &block)
      end

      def run
        parse_arguments
        parse_lists
        require_gems
        run_server
        delete_pid
      end

      def parse_arguments
        @parser.parse
      end

      def parse_lists
        unless Environment.unload
          require 'sword/execute/lists'
          Lists.load
        end
      end

      def require_gems
        require 'sword/execute/gems'
        Gems.require_default
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
