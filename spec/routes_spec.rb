require 'support'
require 'sword/server/routes'

describe Sword::Server::Routes do
  it { should have_method :inject_error }
  it { should have_method :inject_favicon_first }
  it { should have_method :inject_index_first   }
end
