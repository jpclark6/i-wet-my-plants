class GardensController < ApplicationController
  def new
    if current_user.garden
      render file: "/public/404"
    else
      @garden = Garden.new
    end
  end

  def create
    @garden = Garden.new(name: garden_params[:name],
                            twitter_handle: garden_params[:twitter_handle],
                            zip_code: garden_params[:zip_code],
                            user_id: current_user.id,
                            secret_key: SecureRandom.hex(6))

    if @garden.save
      redirect_to plants_path
    else
      @errors = @garden.errors
      render :new
    end
  end

  private

  def garden_params
    params.require(:garden).permit(:name, :twitter_handle, :zip_code)
  end
end
