class GardensController < ApplicationController
  def show
    @plants = current_user.gardens.first.plants
  end
end