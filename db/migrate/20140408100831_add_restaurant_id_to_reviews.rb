class AddRestaurantIdToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :Restaurant, index: true
  end
end
