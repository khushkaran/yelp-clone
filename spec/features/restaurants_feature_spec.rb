require "spec_helper"

describe 'the restaurants index page' do
  context 'no restaurants have been added' do
    it 'should display a warning message' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
    end

    describe "adding a restaurant" do
      it "should be listed on the index" do
      	visit '/restaurants'
      	click_link 'Add a restaurant'
      	fill_in "Name", with: "McDonalds"
      	fill_in "Category", with: "Fast food"
      	fill_in "Location", with: "Everywhere"
      	click_button "Create Restaurant"

      	expect(page).to have_content 'McDonalds'
      end
    end
  end

  context "a restaurant has been added" do
    before(:each) do
      Restaurant.create(name: 'McDonalds')
    end
    it "should edit a restaurant record" do
      visit '/restaurants'
      click_link 'Edit'
      fill_in "Name", with: "Old McDonald"
      click_button 'Update Restaurant'

      expect(page).to have_content 'Old McDonald'
    end

    it "should destroy a restaurant record" do
      visit '/restaurants'
      click_link 'Delete'

      expect(page).to have_content 'No restaurants yet'
    end

    it "should allow a review to be left" do
      visit '/restaurants'
      click_link 'Review'
      fill_in "Comment", with: "Great place!"
      select "5", from: "Rating"
      click_button 'Create Review'

      expect(page).to have_css '#average_rating', :text => 5
    end

    it "should allow the viewing of comments" do
      Restaurant.first.reviews.create(comment: "Amazing!")
      visit '/restaurants'
      expect(page).to have_content 'Amazing!'
    end
  end
end