begin
  require 'simplecov'
rescue LoadError
  # ignore
else
  SimpleCov.start do
    add_group 'EPayCo', 'lib/epayco'
    add_group 'Faraday Middleware', 'lib/faraday'
    add_group 'Specs', 'spec'
  end
end

require File.expand_path('../../lib/epayco', __FILE__)

require 'rspec'
require 'webmock/rspec'
require 'pry'

RSpec.configure do |config|
  config.include WebMock::API
  WebMock.allow_net_connect!
end

def capture_output(&block)
  begin
    old_stdout = $stdout
    $stdout = StringIO.new
    block.call
    result = $stdout.string
  ensure
    $stdout = old_stdout
  end
  result
end

def a_delete(path)
  a_request(:delete, EPayCo.endpoint + path)
end

def a_get(path)
  a_request(:get, EPayCo.endpoint + path)
end

def a_post(path)
  a_request(:post, EPayCo.endpoint + path)
end

def a_put(path)
  a_request(:put, EPayCo.endpoint + path)
end

def stub_delete(path)
  stub_request(:delete, EPayCo.endpoint + path)
end

def stub_get(path)
  stub_request(:get, EPayCo.endpoint + path)
end

def stub_post(path)
  stub_request(:post, EPayCo.endpoint + path)
end

def stub_put(path)
  stub_request(:put, EPayCo.endpoint + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
