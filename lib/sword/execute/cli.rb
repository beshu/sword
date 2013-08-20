require 'optparse'

module Sword
  module Execute
    # Sword command line interface
    # @api private
    class CLI
      def initialize(width = 25, &block)
        @parser = OptionParser.new do |parser|
          @parser = parser
          parser.summary_width = width
          parse_options
          if block_given?
            parser.separator 'Plugin options:'
            yield parser
          end
        end
      end

      def run(arguments = ARGV)
        parse!(arguments)
        require 'sword/execute/manager'
        Manager.new
      end

      def parse(arguments = ARGV)
        parse!(arguments.dup)
      end

      def parse!(arguments = ARGV)
        arguments = get_options unless arguments
        @parser.parse!(arguments)
        @options
      end

      protected

      # Show options menu and then get options from STDIN
      # 
      # @param parser [OptionParser] optparse object
      # @return [Array] options received from STDIN
      # def get_options(parser)
      #   [:INT, :TERM].each { |s| trap(s) { abort "\n" } }
      #   parser.banner = 'Options (press ENTER if none):'
      #   print parser, "\n"
      #   $stdin.gets.split
      # end

      def parse_options
        setters = methods.delete_if { |m| not m.to_s.start_with? 'parse_' }
        setters.delete(:parse_options)
        setters.sort.each { |m| send m }
      end

      include Options
    end
  end
end
