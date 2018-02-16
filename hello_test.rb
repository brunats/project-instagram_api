require './hello'
require 'test/unit'
require 'rack/test'
require 'test/unit/capybara'

set :environment, :test

# Projectinstagram_api classe de testes
class TestMyApp < Test::Unit::TestCase
  include Rack::Test::Methods
  include Capybara::DSL

  def app
    Sinatra::Application
  end

  def setup
    Capybara.app = MyApp.new
  end

  # limpar dados
  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  def test_home_page
    visit('/')
    within('h1') do
      assert_equal('Sejam Bem Vindos', text)
    end
  end

  # def test_home

  # def test_connect
end
