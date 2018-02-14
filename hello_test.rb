require './hello'
require 'test/unit'
# require 'minitest/autorun'
require 'rack/test'

set :environment, :test

class Projectinstagram_api < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_hi_returns_hello_world
    get '/'
    assert last_response.ok?
  end
end
