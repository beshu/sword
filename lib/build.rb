class Build; class << self
  def run!
    puts Dir.pwd.glob("**/*")
  end
end; end
