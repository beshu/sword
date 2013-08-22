$:.unshift File.dirname(__FILE__) + '/../lib'
require 'sword'
require 'sword/server'
require 'rack/test'
require 'erb'

describe Sword::Server::Application do
  Sword::Environment.configure do |e|
    e.directory = './spec/example'
    e.templates = {'templates' => {'erb' => ['erb']}}
    # e.debug = true
  end

  include Rack::Test::Methods
  Sword::Server::Application.inject

  def app
    Sword::Server::Application
  end

  it 'should get /index.html and send it back' do
    get '/index.html'
    last_response.should be_ok
    last_response.body.should == File.read('spec/example/index.html')
  end

  it 'should prefer templates over pure HTML' do
    get '/favourite/page'
    last_response.body.should == File.read('spec/example/favourite/page.erb')
  end

  it 'should synonymize / to /index' do
    get '/'
    last_response.body.should == File.read('spec/example/index.html')
  end

  it 'should synonymize /foo to /foo/index if /foo is not found' do
    get '/synonym'
    last_response.body.should == File.read('spec/example/synonym/index.html')
  end

  it 'should prefer page over /index synonym' do
    get '/no_synonym'
    last_response.body.should == File.read('spec/example/no_synonym.html')
  end
end
