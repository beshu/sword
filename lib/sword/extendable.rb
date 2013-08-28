module Sword
  class Extendable
    def self.inherited(subclass)
      @plugins = []
    end

    def initialize
      @plugins = []
    end
  end
end
