class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @restaurants = Restaurant.all.sort_by(&:average_rating).reverse
    @reviews = Review.order('created_at DESC').limit(5)
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new restaurant_params
    if @restaurant.save
      flash[:success] = "Restaurant created successfully"
      redirect_to '/restaurants'
    else
      @restaurant.errors.full_messages.each do |msg|
        flash[:error] = msg
      end
      render 'new'
    end
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
    flash[:success] = "Restaurant updated successfully"
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
