class Garden < ApplicationRecord
  validates_presence_of :name,
                        :twitter_handle,
                        :zip_code
  belongs_to :user
  has_many :plants

  def plants_by_water_need
    plants.select("plants.*, (EXTRACT(EPOCH FROM ((NOW()) - (last_watered))) - (frequency - 6) * 3600) as needing_water").order('needing_water desc')
  end
end
