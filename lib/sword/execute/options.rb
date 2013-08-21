module Sword
  module Execute
    module Options
      include Debugger
      # def parse_build
      #   @parser.on '-b', '--build', 'Build project into .zip' do
      #     require 'sword/builder'
      #     Builder.new
      #   end
      # end

      def parse_add
        @parser.on '-a', '--add <x,y>', Array, 'Add gems to require' do |gems|
          debuglnup "Adding #{gems.join(', ')} to your #{Environment.local_gems}"
          open(Environment.local_gems, 'a') { |f| gems.each { |g| f.puts g } }
          exit
        end
      end

      def parse_compress
        @parser.on '-c', '--compress', 'Compress assets' do 
          debuglnup 'Compress assets'
          Environment.compress = true
        end
      end

      def parse_daemonize
        if RUBY_VERSION >= '1.9.1'
          @parser.on '--daemonize', 'Daemonize Sword (good for servers)' do
            debuglnup 'Run as UNIX daemon'
            Environment.daemonize = true
          end
        end
      end

      def parse_debug
        @parser.on '--debug', "Show Sword's guts" do
          debugln 'Parsing options:'
          Environment.debug = true
        end
      end

      def parse_directory
        @parser.on '-d', '--directory <path>', 'Specify watch directory' do |path|
          debuglnup "Watch #{path} directory"
          Environment.directory = path
        end
      end

      def parse_error
        @parser.on '-e', '--error <path>', 'Specify error page' do |path|
          debuglnup "Point Sinatra errors at #{path}"
          Environment.error = path
        end
      end

      def parse_favicon
        @parser.on '--favicon <path>', 'Specify favicon' do |path|
          debuglnup "Make #{path} the default favicon"
          Environment.favicon = path
        end
      end

      # def parse_generate
      #   @parser.on '-g', '--generate', 'Generate boilerplate' do
      #     require 'sword/generator'
      #     Generator.new
      #     exit
      #   end
      # end

      def parse_help
        @parser.on '-h', '--help', 'Print this message' do
          debuglnup 'Show help message and #exit'
          puts @parser
          exit
        end
      end

      def parse_install
        @parser.on '-i', '--install', 'Try to install must-have gems' do
          debuglnup 'Installing all gems required by default by Sword and #exit'
          require 'sword/installer'
          Installer.install
          exit
        end
      end

      def parse_here
        @parser.on '--here', "Don't change directory" do
          debuglnup "Skip changing directory to #{Environment.directory}"
          Environment.here = true
        end
      end

      def parse_open
        if RUBY_PLATFORM.include? 'darwin'
          @parser.on '-o', '--open', 'Open in browser (OS X specific)' do
            debuglnup "Open localhost:#{Environment.port} in the browser"
            Environment.open = true
          end
        end
      end

      def parse_port
        @parser.on '-p', '--port <number>', Integer, 'Change the port, 1111 by default' do |number|
          debuglnup "Run server at 127.0.0.1:#{number}"
          Environment.port = number
        end
      end

      def parse_pid
        @parser.on '--pid <path>', 'Make PID file' do |path|
          debuglnup "Put PID file at #{path}"
          Environment.pid = path
        end
      end

      def parse_plain
        @parser.on '--plain', 'Skip heuristically loading gems' do
          debuglnup 'Environment.gem_lists = []'
          Environment.gem_lists = []
        end
      end

      def parse_require
        @parser.on '-r', '--require <x,y>', Array, 'Require these gems this time' do |gems|
          debuglnup "#{gems.join(', ')} added to Environment.gems"
          Environment.gems += gems
        end
      end

      def parse_settings
        @parser.on '-s', '--settings <path>', 'Load settings from file' do |path|
          debuglnup "Loading settings from #{path}..."
          Environment.settings = path
          settings = File.read(path)
          debuglnup(*settings.lines)
          instance_eval settings
        end
      end

      def parse_silent
        @parser.on '--silent', 'Try to turn off any messages' do
          debuglnup "Turn off any #puts or #print messages"
          Environment.silent = true
        end
      end

      def parse_version
        @parser.on '-v', '--version', "Print Sword's version" do
          debuglnup "Print Sword's version and #exit"
          puts 'Sword ' << VERSION
          exit
        end
      end
    end
  end
end
