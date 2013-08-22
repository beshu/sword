$:.unshift File.dirname(__FILE__) + '/../lib'
require 'sword/execute/cli'
require 'stringio'

describe Sword::Execute::CLI do
  before do
    $stderr = StringIO.new
  end

  it 'prints the version and exits' do
    lambda do
      Sword::Execute::CLI.new(['-v']).run
    end.should raise_error SystemExit
    $stderr.string.should == "Sword #{Sword::VERSION}\n"
  end

  # it 'prints help information' do
  #   help = `bin/sword -h`
  #   help.should include("Usage: sword [options]\n")
  # end
end
