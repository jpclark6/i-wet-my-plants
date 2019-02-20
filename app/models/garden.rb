class Garden < ApplicationRecord
  validates_presence_of :name,
                        :twitter_handle,
                        :zip_code
  belongs_to :user
  has_many :plants
  validates_length_of :zip_code, :maximum => 5

  def plants_by_water_need
    unless plants.empty?
      plants.select("plants.*, (EXTRACT(EPOCH FROM ((NOW()) - (last_watered))) - (frequency - 6) * 3600) as needing_water")
            .order('needing_water desc')
    else
      []
    end
  end

  def reset_watering
    plants.update_all(last_watered: Time.now)
  end
end
