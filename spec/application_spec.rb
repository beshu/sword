require File.expand_path('../helper', __FILE__)
require 'sword'
require 'sword/server'
require 'rack/test'
require 'erb'

describe Sword::Server::Application do
  Sword::Environment.configure do |e|
    e.templates = {'templates' => {'erb' => ['erb']}}
    # e.debug = true
  end

  Sword::Server::Application.inject
  include Rack::Test::Methods

  before :all do 
    @initial = Dir.pwd
    Dir.chdir 'spec/example'
  end

  after :all do
    Dir.chdir @initial
  end

  def app
    Sword::Server::Application
  end

  def check(uri, file)
    get uri
    last_response.should be_ok
    last_response.body.should == File.read(file)
  end

  it 'should get /index.html and send it back' do
    check '/index.html', 'index.html'
  end

  it 'should prefer templates over pure HTML' do
    check '/favourite/page', 'favourite/page.erb'
  end

  it 'should prefer HTML if you use HTML extension' do
    check '/favourite/page.html', 'favourite/page.html'
  end

  it 'should synonymize / to /index' do
    check '/', 'index.html'
  end

  it 'should synonymize /foo to /foo/index if /foo is not found' do
    check '/synonym', 'synonym/index.html'
  end

  it 'should prefer page over /index synonym' do
    check '/no_synonym', 'no_synonym.html'
  end

  it 'returns unknown files' do
    check '/unknown.tmp', 'unknown.tmp'
  end

  it 'returns unknown files including templates' do
    check '/favourite/page.erb', 'favourite/page.erb'
  end
end
