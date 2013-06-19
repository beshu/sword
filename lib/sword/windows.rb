module Sword
  class Windows; class << self
    def windows?
      RUBY_PLATFORM =~ /mswin|mingw|cygwin/
    end
  end end
end
