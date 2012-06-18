require "sinatra"
require "mongoid"
require "mongoid_spacial"

require "models/point"

Mongoid.load!("./mongoid.yml")
