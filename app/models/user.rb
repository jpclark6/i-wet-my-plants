class User < ApplicationRecord
  validates_presence_of :name,
                        :zip_code

  has_many :user_gardens
  has_many :gardens, through: :user_gardens

end
