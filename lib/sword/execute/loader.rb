module Sword
  module Execute
    class Loader
      include Debugger

      def initialize(list = Environment.gems)
        @list = list
      end

      def self.load(*args)
        new(*args).load
      end

      def load
        debugln 'Loading gems:'
        @list.each do |element|
          case element
          when Hash
            load_first(element)
          when String
            load_gem(element)
          else
            raise LoadError, "Gem list should contain hashes and strings only," \
            "you have #{element.inspect} which is #{element.class}"
          end
        end
      end

      private

      # List debug
      def ldebug(string)
        sdebug string + '.' * (20 - string.length)
      end

      def load_first(options)
        options.values.first.each do |option|
          begin
            ldebug option
            require option
            debugln "OK"
            break
          rescue LoadError
            debugln "Fail"
            next
          end
        end
      end

      def load_gem(name)
        begin
          ldebug name
          require name
          debugln "OK"
        rescue LoadError
          debugln "Fail"
        end
      end
    end
  end
end
