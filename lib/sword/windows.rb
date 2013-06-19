module Sword
  class Windows; class << self
    def show_menu(options)
      [:INT, :TERM].each { |s| trap(s) { abort "\n" } }
      options.banner = 'Options (press ENTER if none):'
      print options, "\n"
      gets.split
    end

    def windows?
      RUBY_PLATFORM =~ /mswin|mingw|cygwin/
    end
  end end
end
