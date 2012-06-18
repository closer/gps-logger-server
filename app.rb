# -*- coding: utf-8 -*-

require "sinatra"
require "erb"
require "mongoid"
require "mongoid_spacial"

Mongoid.configure do |config|
  if ENV['MONGOLAB_URI']
    conn = Mongo::Connection.from_uri(ENV['MONGOLAB_URI'])
    uri = URI.parse(ENV['MONGOLAB_URI'])
    config.master = conn.db(uri.path.gsub(/^\//, ''))
  else
    config.master = Mongo::Connection.from_uri("mongodb://localhost:27017").db('gps-logger_test')
  end
end

class Point
  include Mongoid::Document
  include Mongoid::Spacial::Document

  field :session,   type: String
  field :timestamp, type: DateTime
  field :location,  type: Array, spacial: true
end

seed = ('0'..'z').to_a

get '/' do
  erb :index
end

get '/session/new' do
  20.times.map{ seed[rand(seed.size)] }
end

post '/track' do
  p params
  if params[:session] && params[:latitude] && params[:longitude]
    Point.create({ session: params[:session], location:{ lat: params[:latitude], lng: params[:longitude] }, timestamp: DateTime.now}).to_json
  else
    {:status => 'failed'}.to_json
  end
end

get '/points/:session' do |session|
  Point.where(:session => session).to_json
end

