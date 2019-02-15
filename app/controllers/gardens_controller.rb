class GardensController < ApplicationController
  def new
    @garden = Garden.new
  end

  def create
    @garden = Garden.create(params)
    if @garden.save
      redirect_to plants_path
      flash[:success] = "Your garden has been created."
    else
      render :new
      flash[:error] = "ERROR: Your garden has not been created."
    end
  end
end
