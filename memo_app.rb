# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pg'

def conn
  @conn ||= PG.connect(dbname: 'memodb')
end

def read_memos
  conn.exec_params('SELECT * FROM memos')
end

def target_memo(id)
  memo = conn.exec_params('SELECT * FROM memos WHERE id = $1', [id])
  memo.tuple_values(0)
end

configure do
  table = conn.exec_params("SELECT * FROM information_schema.tables WHERE table_name = 'memos';")
  conn.exec_params('CREATE TABLE memos (id serial primary key, title varchar(255), content text)') if table.values.empty?
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
  @memos = read_memos
  erb :index
end

get '/memos/new' do
  @page_title = 'new'
  erb :new
end

post '/memos' do
  conn.exec_params('INSERT INTO memos(title, content) VALUES ($1, $2);', [params[:title], params[:content]])
  redirect '/memos'
end

get '/memos/:id/edit' do
  @page_title = 'edit'
  @id = params[:id]
  memo = target_memo(@id)
  @memo_title = memo[1]
  @memo_content = memo[2]
  erb :edit
end

patch '/memos/:id' do
  conn.exec_params('UPDATE memos SET title = $1, content = $2 WHERE id = $3;', [params[:title], params[:content], params[:id]])
  redirect '/memos'
end

get '/memos/:id' do
  @page_title = 'show'
  @id = params[:id]
  memo = target_memo(@id)
  @memo_title = memo[1]
  @memo_content = memo[2]
  erb :show
end

delete '/memos/:id' do
  conn.exec_params('DELETE FROM memos WHERE id = $1', [params[:id]])
  redirect '/memos'
end
