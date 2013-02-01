class Talk; class << self
  def version; '0.2.1' end
  def build; end
  def run
    require "#{$dir}/app"
    Sword.run!
  end
  def help
    puts "Usage: sword [<gem>/build/h/v]",
    "Require a gem: `sword <gem name>`",
    "Build your project: `sword build`"
  end
  # Aliases
  def h; Talk.help; end
  def v; puts "Sword #{self.version}" end
end; end
