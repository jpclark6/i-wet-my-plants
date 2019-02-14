class User < ApplicationRecord
  validates_presence_of :name,
                        :zip_code

  has_many :user_gardens
  has_many :gardens, through: :user_gardens

  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).find_or_create do |new_user|
      new_user.uid                = auth_info.uid
      new_user.name               = auth_info.extra.raw_info.name
      new_user.screen_name        = auth_info.extra.raw_info.screen_name
      new_user.oauth_token        = auth_info.credentials.token
      new_user.oauth_token_secret = auth_info.credentials.secret
    end
  end
end
