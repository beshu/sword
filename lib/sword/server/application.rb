require 'sinatra/base'

module Sword
  module Server
    class Application < ::Sinatra::Base
      NotFoundError = Class.new StandardError
      
      extend Debugger
      extend Sinatra if Environment.CLI
      extend Injector

      helpers { include Helpers }
      include Parser
      
      extend Plugins
      extend Routes
      extend Templates

      inject
    end
  end
end
