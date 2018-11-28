class Api::V1::SpotsController < Api::V1::BaseController
  def index
    # Add condition to check if any tags have been selected to decide what to show.
    # byebug
    if params[:tag_list].nil? || params[:tag_list].empty?
      @spots = Spot.all
    else
      @spots = Spot.tagged_with(params[:tag_list], :match_all => true)
    end
  end

  def show
    @spot = Spot.find(params[:id])
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    if @spot.save
      render :show
      # The render allows WeChat frontend to see what's going on when adding a new element.
    else
      # render_error
    end
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :description, :address, :styles, :user_id)
  end
end
