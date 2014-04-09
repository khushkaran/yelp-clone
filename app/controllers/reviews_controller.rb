class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find params[:restaurant_id]
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find params[:restaurant_id]
    @review = @restaurant.reviews.build params[:review].permit(:comment, :rating)

    if @review.save
      flash[:success] = "Review has been added successfully"
      redirect_to '/restaurants'
    else
      @review.errors.full_messages.each do |msg|
        flash[:error] = msg
      end
      render 'new'
    end
  end
end
