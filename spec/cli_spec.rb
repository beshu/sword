require File.expand_path('../helper', __FILE__)
require 'sword/execute/cli'

describe Sword::Execute::CLI do
  before :each do
    $stderr = StringIO.new
  end

  it 'prints the version and exits' do
    lambda do
      Sword::Execute::CLI.new(['-v']).run
    end.should raise_error SystemExit
    $stderr.string.should == "Sword #{Sword::VERSION}\n"
  end

  it 'prints help information and exits' do
    lambda do
      Sword::Execute::CLI.new(['-h']).run
    end.should raise_error SystemExit
    $stderr.string.should include '--aloud'
    $stderr.string.should include '--mutex'
    $stderr.string.should include 'guts'
  end
end
