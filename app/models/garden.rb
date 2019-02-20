class Garden < ApplicationRecord
  validates_presence_of :name,
                        :twitter_handle,
                        :zip_code
  belongs_to :user
  has_many :plants

  def plants_by_water_need
    unless plants.empty? 
      plants.select("plants.*, (EXTRACT(EPOCH FROM ((NOW()) - (last_watered))) - (frequency - 6) * 3600) as needing_water")
            .order('needing_water desc')
    else
      []
    end
  end

  def plants_that_need_water
    plants.select("plants.*, (EXTRACT(EPOCH FROM ((NOW()) - (last_watered))) - (frequency - 6) * 3600) as needing_water").where("EXTRACT(EPOCH FROM ((NOW()) - (last_watered))) > (frequency - 6) * 3600").order('needing_water desc')
  end
end
