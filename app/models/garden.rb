class Garden < ApplicationRecord
  validates_presence_of :name

  has_many :user_gardens
  has_many :users, through: :user_gardens

  has_many :plants
end
