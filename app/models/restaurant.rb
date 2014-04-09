class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates :name, presence: true

  def average_rating
    return 0 if reviews.length == 0
    reviews.average(:rating).ceil if reviews.average(:rating)
  end

  def last_comment
    return "" if reviews.length == 0
    reviews.last.comment if reviews.last.comment
  end
end
