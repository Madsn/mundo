class User
  include Mongoid::Document
  include Mongoid::Timestamps

	has_many :workouts, dependent: :delete
  field :username, type: String
  field :email, type: String
  field :last_checked, type: DateTime
  field :password, type: String

  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :username, :case_sensitive => false
end
