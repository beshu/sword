module Sword
  class Loader
    extend Output
    class << self
      public
      LOAD_FILE = Dir.home + '/.sword'

      def load(options)
        settings = parse_settings
        options = {
          :directory => Dir.pwd,
          :port => 1111
        }.merge(options)

        include_gems settings['gems']['general']
        include_gems File.read(LOAD_FILE).split("\n") if File.exists? LOAD_FILE
        include_gems settings['gems']['unix'] unless Windows.windows?

        Applicaton.run!(options)
      end

      def install_gems(list)
        exec 'gem install ' +
        list.map { |n| n.respond_to?(:first) ? n.first : n }.delete_if { |g| g['/'] } * ' '
      end

      def append_to_include(name)
        open(LOAD_FILE, 'a') { |f| f.puts name }
        puts "#{g} will be loaded next time you run Sword."
      end

      def load_compass(file = "#{LIBRARY}/compass.rb")
        return {} unless defined? Compass
        Compass.add_project_configuration @compass_file
        Compass.sass_engine_options
      end
      
      private

      def parse_settings(file = "#{LIBRARY}/settings.yml")
        require 'yaml'
        YAML.load_file file
      end

      def include_first(options)
        # Tries to require the first possible gem from options hash
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

      def include_only(name)
        # Tries to require a gem and does nothing if it fails
        begin
          debug lib + '.' * (15 - lib.length), '  '
          require lib
          debug "OK\n"
        rescue LoadError
          debug "Fail\n"
        end
      end

      def include_gems(list)
        debug "Including gems:\n", ' '
        list.each { |l| Hash === l ? include_first(l) : include_only(l) }
      end
    end
  end
end
