$:.unshift('./lib')
require 'sword'
require 'gutenberg/mixins'

class View < Gutenberg::View
  def repo; 'sword' end
  def user; 'somu'  end

  def sword
    "[![Sword](http://so.mu/icons/#{repo}.png)]" \
    "(http://so.mu/blog/#{repo})"
  end

  def dir_sample
    %w[directory/you/wanna/watch your/project/directory].sample
  end

  def options
    parser = Sword::Execute::Parser.new([], 25)
    parser.instance_eval { @parser }.to_s.split("\n")[1..-1].join("\n")
  end

  def version;   Sword::VERSION     end
  def directory; Sword::E.directory end
  def port;      Sword::E.port      end

  def executable; "https://github.com/#{user}/#{repo}/blob/master/#{repo}.exe?raw=true" end
  include Gutenberg::Mixins
end
