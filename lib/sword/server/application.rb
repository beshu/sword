require 'sinatra/base'

module Sword
  module Server
    class Application < ::Sinatra::Base
      NotFoundError = Class.new StandardError
      
      extend Debugger
      extend Sinatra if Environment.CLI
      extend Injector

      helpers { include Helpers }
      include Templates

      extend Plugins
      extend Templates
      extend Routes
      extend Parsers

      inject
    end
  end
end
