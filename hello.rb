# --
# pacotes necessários
# => gem install sinatra thin haml
# => gem install instagram
# http://192.168.0.102:4567/

require "sinatra"
require "instagram"

#coding: utf-8
set :bind, '0.0.0.0'

#Config Instagram
#
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
  haml :index
end

get '/sobre' do
  @titulo = "Instagram API"
  @subtitulo = "O projeto mais top"
  haml :sobre
end

get '/oauth/connect' do
  redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
end

get "/oauth/callback" do
  response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
  session[:access_token] = response.access_token
  redirect "/"
end

get "/user_recent_media" do
	client = Instagram.client(:access_token => session[:access_token])
	user = client.user
	html = "<h1>#{user.username}'s recent media</h1>"
	for media_item in client.user_recent_media
	html << "<div style='float:left;'><img src='#{media_item.images.thumbnail.url}'><br/> <a href='/media_like/#{media_item.id}'>Like</a>  <a href='/media_unlike/#{media_item.id}'>Un-Like</a>  <br/>LikesCount=#{media_item.likes[:count]}</div>"
	end
	html
end

get "/logout" do
	session[:access_token] = nil
	"sair"
	redirect "/"
end
