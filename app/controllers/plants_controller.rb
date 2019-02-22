class PlantsController < ApplicationController
  def index
    @plants = current_user.garden.plants_by_water_need
    location_saved? ? load_location : find_location
    weather_cookies_valid? ? load_weather : find_weather
  end

  def new
    @plant = Plant.new
  end

  def create
    @plant = current_user.garden.plants.create(plant_params)
    @plant.update(last_watered: Time.now)
    if @plant.save
      flash[:success] = "Your plant was added"
      redirect_to plants_path(@plant.id)
    else
      @errors = @plant.errors
      render :new
    end
  end

  def show
    @user = current_user
    @garden = @user.garden
    @plant = @garden.plants.find(params[:id])
    @plant_waterings = @plant.waterings
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
    else
      flash[:error]= "Your plant could not be deleted"
    end
    redirect_to plants_path
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

  def location_saved?
    session[:location]
  end

  def load_location
    @location = session[:location]
  end

  def find_location
    @location = GoogleGeocodeService.new(zip_code).find_city
    session[:location] = @location
  end

  def zip_code
    current_user.garden.zip_code
  end

  def weather_cookies_valid?
    session[:time] && DateTime.parse(session[:time]) < 15.minutes.from_now
  end

  def load_weather
    @current_forecast = session[:current_forecast]
    @current_temp = session[:current_temp]
    @location = session[:location]
  end

  def find_weather
    @current_forecast = DarkSkyFacade.current_forecast(zip_code)
    @current_temp = DarkSkyFacade.current_temp(zip_code)
    session[:current_forecast] = @current_forecast
    session[:current_temp] = @current_temp
    session[:time] = Time.now
  end
end
