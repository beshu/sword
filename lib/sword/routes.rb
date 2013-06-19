module Sword
  class Application
    error do
      @error = env['sinatra.error']
      erb :error, :views => LIBRARY
    end

    get '/favicon.ico' do
      send_file "#{LIBRARY}/favicon.ico"
    end

    get '/' do
      # Call /index, the same shit
      # TODO: for any level
      call env.merge 'PATH_INFO' => '/index'
    end

    parse 'styles', '/*.css', Loader.load_compass
    parse 'scripts', '/*.js'

    get(/(.+?)\.(#{SETTINGS['html'] * '|'})/) do |route, _|
      call env.merge 'PATH_INFO' => route
    end

    parse 'markup', '/*/?' do |page|
      SETTINGS['html'].each { |extension| return send_file(file = "#{page}.#{extension}") if File.exists? file }
      raise NotFound if page =~ /\/index$/ or not defined? env
      call env.merge({'PATH_INFO' => "/#{page}/index"})
    end
  end
end
