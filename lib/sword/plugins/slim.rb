module Sword
  module Server
    def inject_slim
      configure do
        set :slim, :pretty => true unless Environment.compress
      end
    end
  end
end
