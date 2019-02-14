class PlantsController < ApplicationController
  def index
    #garden index page
    @plants = current_user.plants
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
end