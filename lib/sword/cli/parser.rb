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
        arguments = @arguments || get_options
        @parser.parse!(arguments)
      end

      protected

      def include_options
        setters = methods.delete_if { |m| not m.to_s.start_with? 'parse_' }
        setters.sort.map(&:to_sym).each { |m| send m }
      end

      include Options
    end
  end
end
