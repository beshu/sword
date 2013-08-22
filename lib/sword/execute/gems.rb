module Sword
  module Execute
    module Gems
      extend Debugger

      def self.require_list(list)
        debugln 'Including gems:'
        list.each do |element|
          case element
          when Hash
            require_any(element)
          when String
            require_gem(element)
          else
            raise LoadError, "Gem list should contain hashes and strings only," \
              "you have #{element.inspect} which is #{element.class}"
          end
        end
      end

      def self.pretty_debug(string)
        sdebug string + '.' * (20 - string.length)
      end

      def self.require_any(options)
        options.values.first.each do |option|
          begin
            pretty_debug option
            require option
            debug "OK\n"
            break
          rescue LoadError
            debug "Fail\n"
            next
          end
        end
      end

      def self.require_gem(name)
        begin
          pretty_debug name
          require name
          debug "OK\n"
        rescue LoadError
          debug "Fail\n"
        end
      end
    end
  end
end
