# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'

get '/' do
  redirect '/top'
end

get '/top' do
  'メモアプリ'
end
