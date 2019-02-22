class Api::V1::PlantsController < ApiController
  def index
    garden = Garden.find_by(secret_key: params[:key])
    plants = garden.plants_that_need_water_api
    if plants.empty? 
      render json: {status: 'All plants currently watered'}
    else
      render json: PlantSerializer.new(plants)
    end
  end

  def water
    key = Key.new(params[:key])
    if key.valid?
      Plant.water_plant_from_key(key)
      message = "Plant #{key.plant_id} watered successfully"
    else
      message = "Error. Something went wrong. Try again."
    end
    render json: {status: message}
  end
end