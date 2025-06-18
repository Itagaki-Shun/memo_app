# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'

FILE_PATH = 'public/memos.json'

def get_memos(file_path)
  File.open(file_path) { |f| JSON.parse(f.read, symbolize_names: true) }
end

def set_memos(file_path, memos)
  File.open(file_path, 'w') { |f| JSON.dump(memos, f) }
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

get '/' do
  redirect '/memos'
end

get '/memos' do
  @page_title = 'top'
  @memos = get_memos(FILE_PATH)
  erb :top_index
end

get '/memos/new' do
  @page_title = 'new'
  erb :new_index
end

post '/memos' do
  memos = get_memos(FILE_PATH)
  memo_title = params[:title]
  memo_content = params[:content]

  id = SecureRandom.uuid
  memos[id.to_sym] = params.slice(:title, :content)
  set_memos(FILE_PATH, memos)

  redirect '/memos'
end

get '/memos/:id/edit' do
  @page_title = 'edit'
  @id = params[:id]
  memos = get_memos(FILE_PATH)
  memo = memos[@id.to_sym]
  halt 404, 'Not Found!' unless memo
  @memo_title = memo['title']
  @memo_content = memo['content']
  erb :edit_index
end

patch '/memos/:id' do
  id = params[:id]
  memos = get_memos(FILE_PATH)
  memo = memos[@id.to_sym]
  halt 404, 'Not Found!' unless memo
  memo['title'] = params[:title]
  memo['content'] = params[:content]
  set_memos(FILE_PATH, memos)

  redirect '/memos'
end

get '/memos/:id' do
  @page_title = 'show'
  @id = params[:id]
  memos = get_memos(FILE_PATH)
  memo = memos[@id.to_sym]
  halt 404, 'Not Found!' unless memo
  @memo_title = memo['title']
  @memo_content = memo['content']
  erb :show_index
end

delete '/memos/:id' do
  id = params[:id]
  halt 404, 'Not Found!' unless memos.key?(id)
  memos.delete(id)
  set_memos(FILE_PATH, memos)

  redirect '/memos'
end
