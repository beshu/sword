module Sword
  module Server
    module Routes
      SERVED_FIRST = %w[inject_index inject_favicon inject_templates]

      def inject
        injections = methods.delete_if { |m| not m.to_s.start_with? 'inject_' }
        SERVED_FIRST.each { |i| send i; injections - [i] }
        injections.reverse.each { |i| send i }
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
