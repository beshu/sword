module Sword
  require 'rubygems'
  require 'sinatra/base'

  class Application < Sinatra::Base
    NotFound = Class.new StandardError
    extend Output

    class << self
      public

      def run!(options = {})
        options = {:debug => false, :directory => Dir.pwd, :port => 1111, :silent => false}.merge(options)
        @debug, @silent = options[:debug], options[:silent]

        server_settings = settings.respond_to?(:server_settings) ? settings.server_settings : {}
        detect_rack_handler.run self, server_settings.merge(:Port => options[:port], :Host => bind).merge(silent_webrick) do |server|
          [:INT, :TERM].each { |s| trap(s) { quit!(server) } }
          print ">> Sword #{VERSION} at your service!\n" \
          "   http://localhost:#{options[:port]} to see your project.\n" \
          "   CTRL+C to stop.\n"
          debug options.map { |k,v| "## #{k.capitalize}: #{v}\n" }.inject { |sum, n| sum + n }
          unless @debug
            server.silent = true if server.respond_to? :silent
            disable :show_exceptions
          end
          set :views, options[:directory] # Structure-agnostic
          set :slim, :pretty => true
          set :public_folder, settings.views
          server.threaded = settings.threaded if server.respond_to? :threaded
          set :running, true
          yield server if block_given?
        end
      rescue Errno::EADDRINUSE, RuntimeError
        print "!! Port is in use. Is Sword already running?\n"
      end

      private

      def quit!(server)
        print "\n"
        server.respond_to?(:stop!) ? server.stop! : server.stop
      end

      def silent_webrick
        return {} if @debug or not defined? WEBrick
        return {:AccessLog => [], :Logger => WEBrick::Log::new('NUL', 7)} if Windows.windows?
        {:AccessLog => [], :Logger => WEBrick::Log::new('/dev/null', 7)}
      end

      def parse(list_name, pattern, options = {}, &block)
        # list_name :: String    List received from parse.yml
        # pattern   :: String    Ordinary Rack pattern (should be like '/*.css')
        # options   :: Hash      List of options to give to the found Tilt engine
        # &block    :: Block     Block to run if nothing is found (yields * from pattern)
        self.get pattern do |name|
          SETTINGS[list_name].map { |e| String === e ? {e => [e]} : e }.each do |language|
            language.each do |engine, extensions| extensions.each do |extension|
              # Iterate through extensions and find the engine you need.
              return send engine, name.to_sym, options if File.exists? "#{name}.#{extension}"
            end end
          end
          block_given? ? yield(name) : raise(NotFound)
        end
      end
    end

    helpers { include Helpers }
  end
end
