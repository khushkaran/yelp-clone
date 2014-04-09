class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    @reviews = Review.order('created_at DESC').limit(2)
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    Restaurant.create restaurant_params
    redirect_to '/restaurants'
  end

  def edit
    @restaurant = Restaurant.find params[:id]
  end

  def show
    @restaurant = Restaurant.find params[:id]
  end

  def update
    @restaurant = Restaurant.find params[:id]
    @restaurant.update restaurant_params
    redirect_to '/restaurants'
  end

  def destroy
    @restaurant = Restaurant.find params[:id]
    @restaurant.destroy
    flash[:alert] = "Restaurant deleted successfully"
    redirect_to '/restaurants'
  end

  private
  def restaurant_params
    params[:restaurant].permit(:name, :location, :category)
  end
  
end
