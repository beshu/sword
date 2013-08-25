$:.unshift File.dirname(__FILE__) + '/../lib'

# Temple compatability fix
#
module ActionView
  class Template
    def self.method_missing(method, *args)
      method
    end
  end
end

module ActionPack
  module VERSION
    MAJOR = 3
    MINOR = 50
  end
end

require 'sword/execute/cli'
Sword::Execute::CLI.new(false).run
