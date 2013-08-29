module Sword
  class Extendable
    def self.inherited(subclass)
      @plugins ||= []
      @plugins << subclass
    end
  end
end
