module Sword
  module Server
    module Routes      
      def inject
        methods.delete_if do |m|
          not m.to_s.start_with? 'inject_'
        end.reverse.each { |m| send m } 
      end

      def inject_error
        error do
          @error = env['sinatra.error']
          erb File.read(Environment.error)
        end
      end

      def inject_favicon
        get '/favicon.ico' do
          send_file Environment.favicon
        end
      end

      def inject_index
        get '/' do
          # Call /index, the same shit
          call env.merge 'PATH_INFO' => '/index'
        end
      end
    end
  end
end
