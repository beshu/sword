require 'sword'

module Sword
  module Execute
    # Sword command line interface
    # @api private
    class CLI
      def initialize(arguments = ARGV, width = 25)
        @parser = Parser.new(arguments, 25)
        Environment.CLI = true
      end

      include Steps

      def run
        require_rubygems
        parse_arguments
        load_templates
        filter_templates
        load_gems
        daemonize if Environment.daemonize
        #redirect_stderr if Environment.log
        change_directory unless Environment.here
        open_browser unless Environment.console
        run_server
        delete_pid if Environment.pid
      end
    end
  end
end
