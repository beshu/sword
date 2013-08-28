module Sword
  module Execute
    class Options < Sword::Extendable
      include Debugger

      def parse_add
        @parser.on '-a', '--add <x,y>', Array, 'Permanently require the gems' do |gems|
          sdebugln "Adding #{gems.join(', ')} to your #{Environment.local_gems}"
          open(Environment.local_gems, 'a') { |f| gems.each { |g| f.puts g } }
          exit
        end
      end

      def parse_aloud
        @parser.on '--aloud', "Show server's guts" do
          Environment.aloud = true
        end
      end

      def parse_compile
        @parser.on '--compile', 'Compile Sword queries' do
          Environment.compile = true
        end
      end

      def parse_compress
        @parser.on '-c', '--compress', 'Compress assets' do 
          sdebugln 'Compress assets'
          Environment.compress = true
        end
      end

      def parse_daemonize
        unless System::OLD_RUBY
          @parser.on '--daemonize', 'Daemonize Sword (good for servers)' do
            sdebugln 'Run as UNIX daemon'
            Environment.daemonize = true
          end
        end
      end

      # def parse_debug
      #   @parser.on '--debug', "Show Sword's guts" do
      #     Environment.debug = true
      #     debugln 'Parsing options:'
      #   end
      # end

      def parse_directory
        @parser.on '-d', '--directory <path>', 'Specify watch directory' do |path|
          sdebugln "Watch #{path} directory"
          Environment.directory = path
        end
      end

      def parse_error
        @parser.on '--error <path>', 'Specify error page' do |path|
          sdebugln "Point Sinatra errors at #{path}"
          Environment.error = path
        end
      end

      def parse_exceptions
        @parser.on '--exceptions', "Show defaul Sinatra exception page" do
          Environment.exceptions = true
        end
      end

      def parse_help
        @parser.on '-h', '--help', 'Print this message' do
          sdebugln 'Show help message and #exit'
          puts @parser
          exit
        end
      end

      def parse_host
        @parser.on '--host <address>', 'Specify host (default is localhost)' do |address|
          Environment.host = address
        end
      end

      def parse_install
        unless System::OCRA
          @parser.on '-i', '--install', 'Install must-have gems using RubyGems' do
            sdebugln 'Installing all gems required by default by Sword and #exit'
            require 'sword/installer'
            Installer.install
            exit
          end
        end
      end

      def parse_here
        @parser.on '--here', "Don't change directory" do
          sdebugln "Skip changing directory to #{Environment.directory}"
          Environment.here = true
        end
      end

      # def parse_log
      #   @parser.on '-l', '--log <path>', 'Redirect stderr into the file' do |path|
      #     sdebugln "Logging into #{path}"
      #     Environment.log = path
      #   end
      # end

      def parse_mutex
        @parser.on '--mutex', 'Turn on the mutex lock' do
          Environment.mutex = true
        end
      end

      def parse_no_layouts
        @parser.on '--no-layouts', 'Turn off layouts at all (pretty faster)' do
          Environment.layout_lists = []
        end
      end

      def parse_port
        @parser.on '-p', '--port <number>', Integer, 'Change the port, 1111 by default' do |number|
          sdebugln "Run server at 127.0.0.1:#{number}"
          Environment.port = number
        end
      end

      def parse_pid
        @parser.on '--pid <path>', 'Make PID file' do |path|
          sdebugln "Put PID file at #{path}"
          Environment.pid = path
        end
      end

      def parse_plain
        @parser.on '--plain', 'Skip including gems from built-in list' do
          sdebugln 'Environment.gem_lists = []'
          Environment.gem_lists = []
        end
      end

      def parse_production
        @parser.on '--production', 'Apply production settings' do
          Environment.configure do |e|
            e.console = true
            e.daemonize = true unless System::OLD_RUBY
            e.compress = true
            e.cache = true
          end
        end
      end

      def parse_require
        @parser.on '-r', '--require <x,y>', Array, 'Require the gems this run' do |gems|
          sdebugln "#{gems.join(', ')} added to Environment.gems"
          Environment.gems += gems
        end
      end

      def parse_server
        @parser.on '--server <name>', 'Specify server' do |name|
          Environment.server = name
        end
      end

      def parse_settings
        @parser.on '-s', '--settings <path>', 'Load settings from the file' do |path|
          sdebugln "Loading settings from #{path}..."
          Environment.settings = path
          settings = File.read(path)
          sdebugln(*settings.lines)
          instance_eval settings
        end
      end

      def parse_scripts
        @parser.on '--scripts <x,y>', Array, 'List script engines you want to use' do |engines|
          Environment.filter_scripts = engines
        end
      end

      def parse_styles
        @parser.on '--styles <x,y>', Array, 'List style engines you want to use' do |engines|
          Environment.filter_styles = engines
        end
      end

      def parse_templates
        @parser.on '--templates <x,y>', Array, 'List template engines you want to use' do |engines|
          Environment.filter_templates = engines
        end
      end

      def parse_silent
        @parser.on '--silent', 'Turn off any messages excluding exceptions' do
          sdebugln "Turn off any #puts or #print messages"
          Environment.silent = true
        end
      end

      def parse_version
        @parser.on '-v', '--version', "Print Sword's version" do
          sdebugln "Print Sword's version and #exit"
          puts 'Sword ' << VERSION
          exit
        end
      end
    end
  end
end
