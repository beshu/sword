module Sword
  module Boot
    module Require
      def require_gems(list)
        debug "Including gems:\n", ' '
        list.each do |l|
          if Hash === l
            require_first_avaliable(l)
          elsif String === l
            require_if_avaliable(l)
          else
            raise LoadError, 'require list should contain hashes and strings only'
          end
        end
      end

      def require_first_avaliable(hash)
        options.values.first.each do |option|
          begin
            debug option + '.' * (15 - option.length), '  '
            require option
            debug "OK\n"
            break
          rescue LoadError
            debug "Fail\n"
            next
          end
        end
      end

      def require_if_avaliable(name)
        begin
          debug lib + '.' * (15 - lib.length), '  '
          require lib
          debug "OK\n"
        rescue LoadError
          debug "Fail\n"
        end
      end
    end
  end
end
