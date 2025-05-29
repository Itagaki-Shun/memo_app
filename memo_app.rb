# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'

get '/' do
  redirect '/top'
end

get '/top' do
  @title = 'top'
  @memo_title = '仮の実装'
  erb :top_index
end
