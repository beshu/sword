# coding: utf-8
module Sword
  module Execute
    module Options
      # def parse_build
      #   @parser.on '-b', '--build', 'Build project into .zip' do
      #     require 'sword/builder'
      #     Builder.new
      #   end
      # end

      def parse_compress
        @parser.on '-c', '--compress', 'Compress assets' do 
          Environment.compress = true
        end
      end

      def parse_daemonize
        if RUBY_VERSION >= '1.9.1'
          @parser.on '--daemonize', 'Daemonize Sword (good for servers)' do
            Process.daemon
          end
        else
          begin
            require 'daemons'
            @parser.on '--daemonize', 'Daemonize Sword using daemons gem' do
              Daemons.daemonize
            end
          rescue LoadError
          end
        end
      end

      def parse_debug
        @parser.on '--debug', 'Show server’s guts' do
          Environment.debug = true
        end
      end

      def parse_dir
        @parser.on '-d', '--directory <name>', 'Specify watch directory' do |name|
          Environment.directory = name
        end
      end

      def parse_error
        @parser.on '-e', '--error <page>', 'Specify error page' do |page|
          Environment.error = page
        end
      end

      def parse_favicon
        @parser.on '-f', '--favicon <path>', 'Specify favicon' do |path|
          Environment.favicon = path
        end
      end

      def parse_gem
        @parser.on '--gem <name>', 'Add a gem to require' do |name|
          open(Environment.local_gems, 'a') { |f| f.puts name }
          exit
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
          puts @parser
          exit
        end
      end

      def parse_install
        @parser.on '-i', '--install', 'Try to install must-have gems' do
          require 'sword/installer'
          Installer.install
          exit
        end
      end

      def parse_port
        @parser.on '-p', '--port <number>', 'Change the port, 1111 by default' do |number|
          Environment.port = number
        end
      end

      def parse_pid
        @parser.on '--pid <path>', 'Make PID file' do |path|
          Environment.pid = path
          open(path, 'w') { |f| f.puts Process.ppid }
        end
      end

      def parse_require
        @parser.on '-r', '--require <gem>', 'Require the gem this time' do |g|
          Environment.gems << g
        end
      end

      def parse_settings
        @parser.on '-s', '--settings <path>', 'Load settings from file' do |path|
          require 'sword/settings'
          Environment.settings = path
          Environment.load(path)
        end
      end

      def parse_silent
        @parser.on '--silent', 'Try to turn off any messages' do
          Environment.silent = true
        end
      end

      def parse_unload
        @parser.on '-u', '--unload', 'Skip heuristically loading gems' do
          Environment.unload = true
        end
      end

      def parse_version
        @parser.on '-v', '--version', 'Print Sword’s version' do
          puts 'Sword ' << VERSION
          exit
        end
      end
    end
  end
end
