module Sword
  module Boot
    module Gems
      def install_gems(list)
        exec 'gem install ' +
        list.map { |n| n.respond_to?(:first) ? n.first : n }.delete_if { |g| g['/'] } * ' '
      end

      def append_to_include(name)
        open(LOAD_FILE, 'a') { |f| f.puts name }
        puts "#{g} will be loaded next time you run Sword."
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

      def require_gems(list)
        debug "Including gems:\n", ' '
        list.each { |l| Hash === l ? require_first_avaliable(l) : require_if_avaliable(l) }
      end
    end
  end
end
