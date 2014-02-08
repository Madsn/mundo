class Workout
  include Mongoid::Document
  include Mongoid::Timestamps
  Mongoid::Attributes::Dynamic

	belongs_to :user

  field :username, type: String
  field :sport, type: Integer
  field :distance_km, type: Float
  field :start_time, type: DateTime
  field :duration_sec, type: Integer
end
