require "spec_helper"

describe 'validations' do
  context "these fields are required" do
    it "comment" do
      review = Review.new(comment: nil)
      expect(review).to have(1).errors_on(:comment)
    end
    it "rating" do
      review = Review.new(rating: nil)
      expect(review).to have(2).errors_on(:rating)
    end
  end

  context "rating is between 1 and 5" do
    it "is not greater than 5" do
      review = Review.new(rating: 7)
      expect(review).to have(1).errors_on(:rating)
    end
    it "is not lower than 1" do
      review = Review.new(rating: -7)
      expect(review).to have(1).errors_on(:rating)
    end
  end
end