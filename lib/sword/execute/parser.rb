require 'optparse'

module Sword
  module Execute
    class Parser
      def initialize(arguments, width)
        @arguments = arguments
        @parser = OptionParser.new do |parser|
          @parser = parser
          parser.summary_width = width
          include_options unless arguments.nil?
        end
      end

      def parse
        arguments = @arguments || []
        @parser.parse!(arguments)
      end

      protected

      # Show options menu and then get options from STDIN
      # 
      # @param parser [OptionParser] optparse object
      # @return [Array] options received from STDIN
      def get_options
        [:INT, :TERM].each { |s| trap(s) { abort "\n" } }
        @parser.banner = 'Options (press ENTER if none):'
        print @parser, "\n> "
        $stdin.gets.split
      end

      def include_options
        setters = methods.delete_if { |m| not m.to_s.start_with? 'parse_' }
        setters.sort.map(&:to_sym).each { |m| send m }
      end

      include Options
    end
  end
end
