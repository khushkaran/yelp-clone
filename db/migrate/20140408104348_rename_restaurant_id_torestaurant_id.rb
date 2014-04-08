class RenameRestaurantIdTorestaurantId < ActiveRecord::Migration
  def change
    rename_column :reviews, :Restaurant_id, :restaurant_id
  end
end
