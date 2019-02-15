class PlantsController < ApplicationController
  def index
    #garden index page
    @plants = current_garden.plants if current_garden
  end

  def new
    @plant = Plant.new
  end

  def create
    garden = current_user.garden
    @plant = garden.plants.create(plant_params)
    if @plant.save
      redirect_to plants_path(@plant.id)
      flash[:success] = "Your plant was added"
    else
      flash[:error] = "Invalid Info"
      render :new
    end
  end

  def show
    #plant show page
  end

  def edit
    #plant edit page
  end

  def water
    #add water method on plant instance
    redirect_to garden_path
  end

  def water_all
    #add water method on plant instance
    redirect_to garden_path
  end

  private

  def plant_params
  params.permit(:name, :species, :frequency)
  end
end
