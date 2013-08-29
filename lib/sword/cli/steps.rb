module Sword
  module Execute
    class Steps < Sword::Extendable
      step :require_rubygems, System::OLD_RUBY do
        require 'rubygems'
      end

      step :parse_arguments do
        @parser.parse
      end

      step :load_templates do
        require 'sword/execute/lists'
        Lists.load
      end

      step :filter_templates do
        require 'sword/execute/filter'
        Filter.filter
      end

      step :load_gems do
        require 'sword/execute/loader'
        Loader.load
      end

      step :daemonize, E.daemonize do
        Process.daemon(true)
      end

      step :change_directory, !E.here do
        Dir.chdir E.directory
      end

      step :open_browser, !E.console do
        Thread.new do
          sleep 0.75
          url = "http://localhost:#{E.port}"
          if System::OSX
            system "open #{url}"
          else
            require 'launchy'
            Launchy.open(url) {}
          end
        end
      end

      step :run_server do
        require 'sword/server'
        Server::Application.inject
        Server::Application.run!
      end

      step :delete_pid, E.pid do
        File.delete(E.pid)
      end
    end
  end
end
