class User < ApplicationRecord
  validates_presence_of :name
  validates :uid, uniqueness: true, presence: true

  has_one :garden

  def self.find_or_create_from_auth_hash(auth_hash)
    user = User.find_or_create_by(uid: auth_hash["uid"])
    user.name = auth_hash["info"]["name"]
    user.oauth_token = auth_hash["credentials"]["token"]
    user
  end
end
