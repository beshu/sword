require 'support'
require 'sword/server/plugins'

describe Sword::Server::Plugins do
  it { should have_method :inject_slim    }
  it { should have_method :inject_compass }
end
