class RenameGToRatingOnReviews < ActiveRecord::Migration
  def change
    rename_column :reviews, :g, :rating
  end
end
