require "spec_helper"

describe 'validations' do
  context "these fields are required" do
    it "comment" do
      review = Review.new(comment: nil)
      expect(review).to have(1).errors_on(:comment)
    end
    it "rating" do
      review = Review.new(rating: nil)
      expect(review).to have(1).errors_on(:rating)
    end
  end
end