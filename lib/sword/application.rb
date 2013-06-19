module Sword
  require 'rubygems'
  require 'sinatra/base'

  class Application < Sinatra::Base
    NotFound = Class.new StandardError
    extend Output

    class << self
      public

      def run!(options = {})
        @debug, @silent = options[:debug], options[:silent]
        server_settings = settings.respond_to?(:server_settings) ? settings.server_settings : {}

        detect_rack_handler.run self, modify_settings(server_settings) do |server|
          [:INT, :TERM].each { |s| trap(s) { quit!(server) } }
          print ">> Sword #{VERSION} at your service!\n" \
          "   http://localhost:#{options[:port]} to see your project.\n" \
          "   CTRL+C to stop.\n"
          
          options.map { |k,v| debug "#{k.capitalize}: #{v}", '#' }
          specify_directory options[:directory]

          unless @debug
            server.silent = true if server.respond_to? :silent=
            disable :show_exceptions
          end

          server.threaded = settings.threaded if server.respond_to? :threaded
          set :running, true
          yield server if block_given?
        end
      rescue Errno::EADDRINUSE, RuntimeError
        print "!! Port is in use. Is Sword already running?\n"
      end

      private

      def parse(list, pattern, options = {}, &block)
        # list      :: String    List received from settings.yml
        # pattern   :: String    Ordinary Rack pattern (should be like '/*.css')
        # options   :: Hash      List of options to give to the found Tilt engine
        # &block    :: Block     Block to run if nothing is found (yields * from pattern)
        self.get pattern do |name|
          SETTINGS[list].map { |e| String === e ? {e => [e]} : e }.each do |language|
            language.each do |engine, extensions| extensions.each do |extension|
              # Iterate through extensions and find the engine you need.
              return send engine, name.to_sym, options if File.exists? "#{name}.#{extension}"
            end end
          end
          block_given? ? yield(name) : raise(NotFound)
        end
      end

      def modify_settings(settings)
        settings.merge({:Port => options[:port], :Host => bind}).merge(silent_webrick)
      end

      def specify_directory(directory)
        set :views, directory # Structure-agnostic        
        set :public_folder, settings.views
      end

      def quit!(server)
        print "\n"
        server.respond_to?(:stop!) ? server.stop! : server.stop
      end

      def silent_webrick
        return {} if @debug or not defined? WEBrick
        null = Windows.windows? ? 'NUL' : '/dev/null'
        {:AccessLog => [], :Logger => WEBrick::Log::new(null, 7)}
      end
    end

    helpers { include Helpers }
  end
end
