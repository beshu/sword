module Sword
  class Loader
    extend Output
    attr_writer :load_file, :settings_file, :compass_file
    @load_file = Dir.home + '/.sword'
    @settings_file = "#{LIBRARY}/settings.yml"
    @compass_file = "#{LIBRARY}/compass.rb"

    class << self
      public

      def load(options)
        parse_settings 
        include_gems
        Applicaton.run!(options)
      end

      def parse_settings(file = @settings_file)
        require 'yaml'
        YAML.load_file file
      end

      def add_to_load(name)
        open(@load_file, 'a') { |f| f.puts name }
        puts "#{g} will be loaded next time you run Sword."
      end

      def install_gems
        exec 'gem install ' +
        SETTINGS[:gems].map { |n| n.respond_to?(:first) ? n.first : n }.delete_if { |g| g['/'] } * ' '
      end

      def load_compass
        return {} unless defined? Compass
        Compass.add_project_configuration @compass_file
        Compass.sass_engine_options
      end
      
      private

      def include_gems
        debug "Including gems:\n", ' '
        list = SETTINGS['gems']['general']

        unless windows?
          list.concat File.exists?(@load_file) ? File.read(@load_file).split("\n") : []
          list.concat SETTINGS['gems']['unix']
        end

        list.each { |l| Hash === l ? include_any(l) : include_only(l) }
      end

      def include_any(options)
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
    end
  end
end
