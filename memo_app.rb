# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

FILE_PATH = 'public/memos.json'

def get_memos(file_path)
  File.open(file_path) { |f| JSON.parse(f.read) }
end

def set_memos(file_path, memos)
  File.open(file_path, 'w') { |f| JSON.dump(memos, f) }
end

get '/' do
  redirect '/memos'
end

get '/memos' do
  @title = 'top'
  @memos = get_memos(FILE_PATH)
  erb :top_index
end

get '/memos/new' do
  @title = 'new'
  erb :new_index
end

post '/memos' do
  title = params[:title]
  content = params[:content]

  memos = get_memos(FILE_PATH)
  id = ((memos.keys.map(&:to_i).max || 0) + 1).to_s
  memos[id] = { 'title' => title, 'content' => content }
  set_memos(FILE_PATH, memos)

  redirect '/memos'
end

get '/memos/:id/edit' do
  @title = 'edit'
  @id = params[:id]
  memos = get_memos(FILE_PATH)
  @memo_title = memos[params[:id]]['title']
  @memo_content = memos[params[:id]]['content']
  erb :edit_index
end

patch '/memos/:id' do
  id = params[:id]
  title = params[:title]
  content = params[:content]

  memos = get_memos(FILE_PATH)
  memos[id] = { 'title' => title, 'content' => content }
  set_memos(FILE_PATH, memos)

  redirect '/memos'
end

get '/memos/:id' do
  @title = 'show'
  @id = params[:id]
  memos = get_memos(FILE_PATH)
  @memo_title = memos[params[:id]]['title']
  @memo_content = memos[params[:id]]['content']
  erb :show_index
end

delete '/memos/:id' do
  memos = get_memos(FILE_PATH)
  memos.delete(params[:id])
  set_memos(FILE_PATH, memos)

  redirect '/memos'
end
