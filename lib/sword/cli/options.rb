module Sword
  module Execute
    class Options < Sword::Extendable
      desc 'Permanently require the gems'
      parse :add, Array do |gems|
        log.info "Adding #{gems.join(', ')} to your #{Environment.local_gems}"
        open(Environment.local_gems, 'a') { |f| gems.each { |g| f.puts g } }
        exit
      end

      desc "Show server's guts"
      parse :a => :aloud

      parse :compile, 'Compile Sword queries'
      parse :compress, 'Compress assets'

      desc 'Specify watch directory'
      parse :d => :directory do |path|
        env << path
      end

      parse :exceptions, 'Show default Sinatra exception page'
      
      desc 'Print this message'
      parse :h => :help do
        puts message
        exit
      end

      desc 'Specify host (default is localhost)'
      parse :host do |address|
        env << address
      end

      desc 'Install must-have gems using RubyGems'
      parse :i => :install do
        require 'sword/installer'
        Installer.install
        exit
      end

      parse :mutex, 'Turn on the mutex lock'

      desc 'Turn off layouts at all (pretty faster)'
      parse :no_layouts do
        Environment.layout_lists = []
      end

      desc 'Change the port, 1111 by default'
      parse :p => :port do |number|
        Environment.port = number
      end

      desc 'Make PID file'
      parse :pid do |path|
        Environment.pid = path
      end

      desc 'Skip including gems from built-in list'
      parse :plain do
        Environment.gem_lists = []
      end

      desc 'Require the gems this run'
      parse :require, Array do |gems|
        env += gems
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
