# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'

# rubocop:disable Style/MutableConstant
MEMOS = []
# rubocop:enable Style/MutableConstant

get '/' do
  redirect '/top'
end

get '/top' do
  @title = 'top'
  @memos = MEMOS
  erb :top_index
end

get '/new-memo' do
  @title = 'new-memo'
  erb :new_index
end

post '/create-memo' do
  MEMOS << { title: params[:title], content: params[:content] }
  redirect '/top'
end

get '/edit-memo/:id' do
  @title = 'edit-memo'
  @id = params[:id]
  @memo = MEMOS[params[:id].to_i]
  erb :edit_index
end

post '/update/:id' do
  redirect '/top'
end
