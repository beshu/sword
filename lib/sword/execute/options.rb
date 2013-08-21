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
            Environment.daemonize = true
          end
        end
      end

      def parse_debug
        @parser.on '--debug', 'Show server’s guts' do
          Environment.debug = true
        end
      end

      def parse_directory
        @parser.on '-d', '--directory <path>', 'Specify watch directory' do |path|
          Environment.directory = path
        end
      end

      def parse_error
        @parser.on '-e', '--error <path>', 'Specify error page' do |path|
          Environment.error = path
        end
      end

      def parse_favicon
        @parser.on '-f', '--favicon <path>', 'Specify favicon' do |path|
          Environment.favicon = path
        end
      end

      def parse_add
        @parser.on '-a', '--add <x,y>', Array, 'Add gems to require' do |gems|
          open(Environment.local_gems, 'a') { |f| gems.each { |g| f.puts g } }
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

      def parse_here
        @parser.on '--here', "Don't change directory" do
          Environment.here = true
        end
      end

      def parse_open
        if RUBY_PLATFORM.include? 'darwin'
          @parser.on '-o', '--open', 'Open in browser (OS X specific)' do
            Environment.open = true
          end
        end
      end

      def parse_port
        @parser.on '-p', '--port <number>', Integer, 'Change the port, 1111 by default' do |number|
          Environment.port = number
        end
      end

      def parse_pid
        @parser.on '--pid <path>', 'Make PID file' do |path|
          Environment.pid = path
        end
      end

      def parse_plain
        @parser.on '--plain', 'Skip heuristically loading gems' do
          Environment.gem_lists = []
        end
      end

      def parse_require
        @parser.on '-r', '--require <x,y>', Array, 'Require these gems this time' do |gems|
          Environment.gems += gems
        end
      end

      def parse_settings
        @parser.on '-s', '--settings <path>', 'Load settings from file' do |path|
          Environment.settings = path
          instance_eval File.read(path)
        end
      end

      def parse_silent
        @parser.on '--silent', 'Try to turn off any messages' do
          Environment.silent = true
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
