require 'sword'

class View < Gutenberg::View
  @repo = 'sword'
  @user = 'somu'

  def sword
    link image('Sword', "http://so.mu/icons/#{@repo}.png"),
    "http://so.mu/blog/#{@repo}"
  end

  def dir_sample
    %w[directory/you/wanna/watch your/project/directory].sample
  end

  def options
    parser = Sword::Execute::Parser.new([], 25)
    parser.instance_eval { @parser }.to_s.split("\n")[1..-1].join("\n")
  end

  @version   = Sword::VERSION
  @directory = Sword::E.directory
  @port      = Sword::E.port
end
