# --
# pacotes necessários
# => gem install sinatra thin haml
# => gem install instagram
# http://192.168.0.102:4567/

require "sinatra"
require "instagram"

#coding: utf-8
set :bind, '0.0.0.0'

# Configurações Instagram
# 	scope permissões necessárias

enable :sessions

CALLBACK_URL = "http://192.168.0.105:4567/oauth/callback"

Instagram.configure do |config|
  config.client_id = "c7dceb3cadb242fc86c8acf894e444e2"
  config.client_secret = "99a27b9b9f3346d9b408f462e1d5ca7c"
  config.scope = "basic public_content"
  # For secured endpoints only
  #config.client_ips = '<Comma separated list of IPs>'
end

get '/' do
  @titulo = "Instagram API"
  @subtitulo = "O projeto mais top"
  erb :index
end

get '/oauth/connect' do
 	redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
end

get "/oauth/callback" do
  response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
  session[:access_token] = response.access_token
  redirect "/home"
end

get '/home' do
  client = Instagram.client(:access_token => session[:access_token])
  user = client.user
  @titulo = "Instagram API"
  @subtitulo = "Bem vindo "+user.username
  erb :home
end

get "/user_recent_media" do
  client = Instagram.client(:access_token => session[:access_token])
  user = client.user
  @titulo = "Instagram API"
  erb :fotos
end

get "/logout" do

end