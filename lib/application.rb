module Sword
  # Hook-up all gems that we will probably need
  @settings['gems'].concat(@list).each do |lib|
    if lib.instance_of? Hash # Take the first possible variant if there are any
      lib.values.flatten.each { |var| begin require var; break rescue LoadError; next end } 
    else begin require lib; rescue LoadError; end end # Else, just require it
  end

  class Application < Sinatra::Base
    class << self
    # This piece of code is from Sinatra,
    # tweaked a bit to silent Thin server
    # and add Sword version and &c.
      def run! port
        handler = detect_rack_handler
        server_settings = settings.respond_to?(:server_settings) ? settings.server_settings : {}
        handler.run self, server_settings.merge(Port: port, Host: bind) do |server|
          STDERR.print ">> Sword #{VERSION} at your service!\n" +
          "   http://localhost:#{port} to see your project.\n" +
          "   CTRL+C to stop.\n"
          [:INT, :TERM].each { |s| trap(s) { quit! server, handler.name.gsub(/.*::/, '') } }
          server.silent = true unless @debug
          server.threaded = settings.threaded
          set :running, true
          yield server if block_given?
        end
      rescue Errno::EADDRINUSE, RuntimeError
        STDERR.puts "!! Another instance of Sword is running.\n"
      end
      def quit! server, handler_name
        server.stop!
        STDERR.print "\n"
      end
    end

    if defined? Compass
      Compass.add_project_configuration "#{$library}/compass.rb"
      compass = Compass.sass_engine_options
    end

    disable :show_exceptions # show `error.erb`
    set :views, @directory # Structure-agnostic
    set :public_folder, settings.views

    error do
      @error = env['sinatra.error']
      erb :error, :views => $library
    end

    get('/favicon.ico') { send_file "#{$library}/favicon.ico" }

    get '/*.css' do |style|
      return send_file "#{style}.css" if File.exists? "#{style}.css"
      @settings['styles'].each do |k,v| v.each do |e| # for `extension`
        # Iterate through extensions and find the engine you need.
        return send k, style.to_sym, (compass || {}) if File.exists? "#{style}.#{e}"
      end end
      # If none, then raise an exception.
      raise 'Stylesheet not found'
    end

    get '/*.js' do |script|
      return send_file "#{script}.js" if File.exists? "#{script}.js"
      @settings['scripts'].each do |k,v| v.each do |e|
        return send k, script.to_sym if File.exists? "#{script}.#{e}"
      end end
      raise 'Script not found'
    end

    get '/' do
      # Call /index, the same shit
      call env.merge 'PATH_INFO' => '/index'
    end

    get '/*/?' do |page|
      %w[html htm].each do |e|
        # This is specially for dumbasses who use .htm extension.
        # If you know another ultra-dumbass html extension, let me know.
        return send_file "#{page}.#{e}" if File.exists? "#{page}.#{e}"
      end
      @settings['pages'].each do |k,v| v.each do |e|
        # If Slim, then prettify the code so it is OK to read
        return send k, page.to_sym, pretty: true if File.exists? "#{page}.#{e}"
      end end
      # Is it an index? Call it recursively.
      raise "Page not found" if page =~ /index/
      call env.merge('PATH_INFO' => "/#{page}/index") 
    end
  end
end
