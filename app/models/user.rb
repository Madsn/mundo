class User
  include Mongoid::Document
  include Mongoid::Timestamps

	has_many :workouts, dependent: :delete
  field :username, type: String
  field :provider, type: String
  field :uid, type: String
  field :email, type: String
  field :last_checked, type: DateTime
  field :password, type: String #endomondo password

  #validates_presence_of :email, :password, :username
  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :username, :case_sensitive => false

  # run 'rake db:mongoid:create_indexes' to create indexes
  index({ email: 1 }, { unique: true, background: true })
  index({ username: 1 }, { unique: true, background: true })

  def self.from_omniauth(auth, endomondo_password=nil)
    find_by_provider_and_uid(auth["provider"], auth["uid"].downcase) || create_with_omniauth(auth, endomondo_password)
  end

  def self.find_by_provider_and_uid(provider, uid)
    where(provider: provider, uid: uid).first
  end

  def self.create_with_omniauth(auth, endomondo_password)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["name"]
      user.email = auth["info"]["email"].downcase
      user.password = endomondo_password
      p "endomondo password:"
      p auth["info"]["endomondo_password"]
    end
  end
end
