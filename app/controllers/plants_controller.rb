class PlantsController < ApplicationController
  def index
    @plants = current_user.garden.plants_by_water_need
    @zip_code = current_user.garden.zip_code
    @current_forecast = DarkSkyFacade.current_forecast(@zip_code)
    @current_temp = DarkSkyFacade.current_temp(@zip_code)
  end

  def new
    @plant = Plant.new
  end

  def create
    garden = current_user.garden
    @plant = garden.plants.create(plant_params)
    @plant.update(last_watered: Time.now)
    if @plant.save
      redirect_to plants_path(@plant.id)
      flash[:success] = "Your plant was added"
    else
      @errors = @plant.errors
      render :new
    end
  end

  def show
    @user = current_user
    @garden = @user.garden
    @plant = @garden.plants.find(params[:id])
  end

  def edit
    @user = current_user
    @garden = @user.garden
    @plant = @garden.plants.find(params[:id])
  end

  def update
    @user = current_user
    @garden = @user.garden
    @plant = @garden.plants.find(params[:id])
    if @plant.update(plant_params)
      flash[:success]= "Your plant is updated"
      redirect_to plants_path
    else
      @errors = @plant.errors
      render :new
    end
  end

  def destroy
    @user = current_user
    @garden = @user.garden
    @plant = @garden.plants.find(params[:id])
    if @plant.destroy
      flash[:success]= "Your plant has been murdered"
      redirect_to plants_path
    else
      falsh[:error]= "Your plant could not be deleted"
    end
  end

  def water
    plant = Plant.find(params[:id])
    watering = Watering.create(plant_id: plant.id)
    plant.water_plant
    redirect_to plants_path
  end

  def water_all
    current_user.garden.plants.each do |plant|
      watering = Watering.create(plant_id: plant.id)
      plant.water_plant
    end
    redirect_to plants_path
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :species, :frequency)
  end
end
