# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

# rubocop:disable Style/MutableConstant
# MEMOS = []
# rubocop:enable Style/MutableConstant

FILE_PATH = 'public/memos.json'

def get_memos(file_path)
  File.open(file_path) { |f| JSON.parse(f.read) }
end

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

patch '/update/:id' do
  id = params[:id].to_i
  MEMOS[id][:title] = params[:title]
  MEMOS[id][:content] = params[:content]
  redirect '/top'
end

get '/show-memo/:id' do
  @title = 'show-memo'
  @id = params[:id]
  @memo = MEMOS[params[:id].to_i]
  erb :show_index
end

delete '/delete-memo/:id' do
  id = params[:id].to_i
  MEMOS.delete_at(id)
  redirect '/top'
end
