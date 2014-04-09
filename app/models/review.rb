class Review < ActiveRecord::Base
  belongs_to :restaurant
  validates :comment, :rating, presence: true
end
