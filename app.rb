require "sinatra"
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

get '/' do
  # TODO map view
end

post '/track' do
  # TODO tacking
  # :params
  #   - session
  #   - latitude
  #   - longitude

  # TODO saveing
  # Point.create
  #   session
  #   location{ lat, lng }
end

get '/:latitude/:longitude' do |latitude, longitude|
  # TODO Search points from latitude and longitude
end
