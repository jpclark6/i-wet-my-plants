class Garden < ApplicationRecord
  validates_presence_of :name,
                        :twitter_handle,
                        :zip_code
  belongs_to :user
  has_many :plants
end
