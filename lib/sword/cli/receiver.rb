require 'sword'
module Sword
  module CLI
    class Receiver
      def initialize(arguments = ARGV, width = 25)
        @parser = Parser.new(arguments, 25)
        Environment.CLI = true
      end
    end
  end
end
