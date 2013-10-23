module Sword
  $:.unshift File.dirname(__FILE__)
  require 'sword/server'
  Rack::Handler.default.run(Sword::Server.new, :Port => 1111) {|s|$S=s}
end
