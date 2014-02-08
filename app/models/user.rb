class User
  include Mongoid::Document
  include Mongoid::Timestamps

	has_many :workouts, dependent: :delete
  field :username, type: String
  field :provider, type: String
  field :uid, type: String
  field :email, type: String
  field :last_checked, type: DateTime
  field :password, type: String

  #validates_presence_of :email, :password, :username
  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :username, :case_sensitive => false

  # run 'rake db:mongoid:create_indexes' to create indexes
  index({ email: 1 }, { unique: true, background: true })
  index({ username: 1 }, { unique: true, background: true })

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.username = auth['info']['name'] || ""
        user.email = auth['info']['email'] || ""
        user.password = "jqntkvak"
      end
    end
  end
end
