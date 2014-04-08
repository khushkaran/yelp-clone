require 'spec_helper'

describe "Restaurant average_rating" do
  let(:restaurant) { Restaurant.create(name: 'McDonalds') } 
  context "with no ratings" do
    it "expect to return no reviews" do
      expect(restaurant.average_rating).to eq "N/A" 
    end
  end

  context "with 1 rating" do
    it "expect to return 5" do
      restaurant.reviews.create(rating: 5)
      expect(restaurant.average_rating).to eq 5
    end
  end

  context "with 2 ratings" do
    it "expect to return 3" do
      restaurant.reviews.create(rating: 5)
      restaurant.reviews.create(rating: 1)
      expect(restaurant.average_rating).to eq 3
    end
  end
end

describe "Restaurant last_comment" do
  let(:restaurant) { Restaurant.create(name: 'McDonalds') } 
  context "with no ratings" do
    it "expect to return nothing" do
      expect(restaurant.last_comment).to eq "" 
    end
  end

  context "with 1 rating" do
    it "expect to return 5" do
      restaurant.reviews.create(comment: "Amazing!")
      expect(restaurant.last_comment).to eq "Amazing!"
    end
  end

  context "with 2 ratings" do
    it "expect to return 3" do
      restaurant.reviews.create(comment: "Amazing!")
      restaurant.reviews.create(comment: "Epic!")
      expect(restaurant.last_comment).to eq "Epic!"
    end
  end
end