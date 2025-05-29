# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'

# rubocop:disable Style/MutableConstant
MEMO_TITLES = []
# rubocop:enable Style/MutableConstant

get '/' do
  redirect '/top'
end

get '/top' do
  @title = 'top'
  @memo_titles = MEMO_TITLES
  erb :top_index
end

get '/new-memo' do
  @title = 'new-memo'
  erb :new_index
end

post '/create-memo' do
  title = params[:title]
  MEMO_TITLES << title unless title.nil? || title.empty?
  redirect '/top'
end
