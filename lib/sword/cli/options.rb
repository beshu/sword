module Sword
  module Execute
    class Options < Sword::Extendable
      desc 'Permanently require the gems'
      parse :add, Array do |gems|
        log.info "Adding #{gems.join(', ')} to your #{Environment.local_gems}"
        open(Environment.local_gems, 'a') { |f| gems.each { |g| f.puts g } }
        exit
      end

      parse :aloud, "Show server's guts"
      parse :compile, 'Compile Sword queries'

      desc 'Specify watch directory'
      parse :d => :directory do |path|
        env << path
      end
      
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

      desc 'Change the port, 1111 by default'
      parse :p => :port do |number|
        env = number
      end

      desc 'Make PID file'
      parse :pid do |path|
        env = path
      end

      desc 'Skip including gems from built-in list'
      parse :plain do
        Environment.gem_lists = []
      end

      desc 'Require the gems this run'
      parse :require, Array do |gems|
        env += gems
      end

      desc 'Specify server'
      parse :server do |name|
        env = name
      end

      desc 'Load settings from the file'
      parse :settings do |path|
        instance_eval File.read(path)
      end

      parse :silent, 'Turn off any messages excluding exceptions'

      desc "Print Sword's version"
      parse :version do
        puts "Sword #{VERSION}"
        exit
      end
    end
  end
end
