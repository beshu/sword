require 'support'
require 'sword/server/sinatra'

describe Sword::Server::Sinatra do
  it { should have_method :run!  }
  it { should have_method :quit! }
  it { should have_method :silent_webrick }
end
