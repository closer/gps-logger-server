class Point
  include Mongoid::Document
  include Mongoid::Spacial::Document

  field :session, type: String
  field :location, type: Array, spacial: true
end
