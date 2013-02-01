class Talk; class << self
  def version; '0.3.0' end
  def build; end
  def run
    require "#{$dir}/app"
    Sword.run!
  end
  def help
    puts "Usage: sword [<gem>/build/h/v]",
    "Require a gem: `sword <gemname>`",
    "Build your project: `sword build`"
  end
  def gem names
    $engine['gems'] << names.flatten
    puts "Next time you run Sword,"
    puts names[1].nil? ? 
      "`#{names}` gem will be avaliable." :
      "`#{names * '`, `'}` gems will be avaliable."
  end
  # Aliases
  def h; self.help; end
  def v; puts "Sword #{self.version}" end
end; end
