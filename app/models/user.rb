class User < ApplicationRecord
  validates_presence_of :name
  validates :uid, uniqueness: true, presence: true

  has_many :user_gardens
  has_many :gardens, through: :user_gardens

  def self.find_or_create_from_auth_hash(auth_hash)
    user = User.find_or_create_by(uid: auth_hash["uid"])
    user.name = auth_hash["info"]["name"]
    user.oauth_token = auth_hash["credentials"]["token"]
    if user.save
      flash[:success] = "Welcome #{user.name}"
      user
    else
      flash[:error] = "Login failed"
    end
  end
end
