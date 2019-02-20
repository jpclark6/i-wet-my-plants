class Api::V1::PlantsController < ApplicationController
  def index
    garden = Garden.find_by(secret_key: params[:key])
    plants = garden.plants_that_need_water
    render json: PlantsSerializer.new(plants)
  end

  def water
    if Key.valid?(params[:key])
      plant_id = Key.find_id(params[:key])
      Plant.find(plant_id).water_plant
      message = "Plant #{plant_id} watered successfully"
    else
      message = "Error. Something went wrong. Try again."
    end
    render json: {status: message}
  end
end