module Sword
  module Plugins
    class Deploy < Sword::CLI::Options
      inject :slim do
        set :slim, :pretty => true unless E.compress
      end
    end
  end
end
