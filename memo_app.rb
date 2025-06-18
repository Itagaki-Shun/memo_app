# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'

FILE_PATH = 'public/memos.json'

def get_memos(file_path = FILE_PATH)
  File.open(file_path) { |f| JSON.parse(f.read, symbolize_names: true) }
end

def set_memos(memos, file_path = FILE_PATH)
  File.open(file_path, 'w') { |f| JSON.dump(memos, f) }
end

helpers do
  def target_memo(memos, id)
    memo = memos[id.to_sym]
    halt 404, 'Not Found!' unless memo
    memo
  end

  def h(text)
    Rack::Utils.escape_html(text)
  end
end

get '/' do
  redirect '/memos'
end

get '/memos' do
  @page_title = 'top'
  @memos = get_memos
  erb :index
end

get '/memos/new' do
  @page_title = 'new'
  erb :new
end

post '/memos' do
  memos = get_memos
  id = SecureRandom.uuid
  memos[id.to_sym] = params.slice(:title, :content)
  set_memos(memos)

  redirect '/memos'
end

get '/memos/:id/edit' do
  @page_title = 'edit'
  @id = params[:id]
  memos = get_memos
  @current_memo = target_memo(memos, @id)
  erb :edit
end

patch '/memos/:id' do
  id = params[:id]
  memos = get_memos
  current_memo = target_memo(memos, id)
  current_memo[:title] = params[:title]
  current_memo[:content] = params[:content]
  set_memos(memos)

  redirect '/memos'
end

get '/memos/:id' do
  @page_title = 'show'
  @id = params[:id]
  memos = get_memos
  @current_memo = target_memo(memos, @id)
  erb :show
end

delete '/memos/:id' do
  id = params[:id]
  memos = get_memos
  target_memo(memos, id)
  memos.delete(id.to_sym)
  set_memos(memos)

  redirect '/memos'
end
