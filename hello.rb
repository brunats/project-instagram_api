# --
# http://192.168.0.102:4567/

require 'sinatra'
require 'Instagram'
#coding: utf-8
set :bind, '0.0.0.0'

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

get '/conecte' do
	@titulo = "Instagram API"
  	@subtitulo = "O projeto mais top"
  	haml :conecte
end