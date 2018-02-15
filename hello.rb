# --
# http://192.168.0.102:4567/
# http://192.168.0.105:4567/

require 'sinatra'
require 'instagram'

# coding: utf-8
set :bind, '0.0.0.0'

# Configuracoes Instagram
#   scope permissoes necessarias

enable :sessions

CALLBACK_URL = 'http://192.168.0.105:4567/oauth/callback'.freeze

Instagram.configure do |config|
  config.client_id = 'c7dceb3cadb242fc86c8acf894e444e2'
  config.client_secret = '99a27b9b9f3346d9b408f462e1d5ca7c'
  config.scope = 'basic public_content'
  # For secured endpoints only
  # config.client_ips = '<Comma separated list of IPs>'
end

get '/' do
  @titulo = 'Instagram API'
  @subtitulo = 'O projeto mais top'
  erb :index
end

get '/oauth/connect' do
  redirect Instagram.authorize_url(redirect_uri: CALLBACK_URL)
end

get '/oauth/callback' do
  if params[:code]
    par_code = params[:code]
    response = Instagram.get_access_token(par_code, redirect_uri: CALLBACK_URL)
    session[:access_token] = response.access_token
    redirect '/home'
  elsif params[:error]
    @titulo = 'Instagram API'
    @subtitulo = 'O projeto mais top'
    @msg_erro = params[:error_description]
    erb :erro_login
  else
    redirect Instagram.authorize_url(redirect_uri: CALLBACK_URL)
  end
end

get '/home' do
  if session[:access_token]
    client = Instagram.client(access_token: session[:access_token])
    user = client.user
    @titulo = 'Instagram API'
    @subtitulo = 'Bem vindo ' + user.username
    erb :home
  else
    redirect '/'
  end
end

get '/user_recent_media' do
  if session[:access_token]
    @titulo = 'Instagram API'
    erb :fotos
  else
    redirect '/'
  end
end

get '/logout' do
  @titulo = 'Instagram API'
  session[:access_token] = nil
  redirect '/'
end
