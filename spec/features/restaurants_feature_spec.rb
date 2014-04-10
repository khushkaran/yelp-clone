require "spec_helper"

describe 'the restaurants index page' do
  context 'no restaurants have been added' do
    it 'should display a warning message' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
    end

    describe "adding a restaurant" do
      context "whilst NOT logged in" do
        it "should allow user to add a restaurant" do
          visit '/restaurants'
          click_link 'Add a restaurant'

          expect(page).not_to have_field 'Name'
          expect(page).to have_content 'You need to sign in or sign up before continuing.'
        end
      end

      context "whilst logged in" do
        it "should be listed on the index" do
          user = User.create(email: 'a@a.com', password: '12345678', password_confirmation: '12345678')
          login_as(user)
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
  end

  context "a restaurant has been added" do
    before(:each) do
      @restaurant = Restaurant.create(name: 'McDonalds')
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

      expect(page).to have_css '.average_rating span', :count => 5
    end

    it "should allow the viewing of the last comment" do
      Restaurant.first.reviews.create(comment: "Amazing!", rating: 5)
      visit '/restaurants'
      expect(page).to have_content 'Amazing!'
    end
    
    context "with reviews posted" do
      before do
        @restaurant.reviews.create(rating: 3, comment: 'Food was OK')
      end

      it "individual restaurants display the reviews" do
        visit '/restaurants'
        click_link "McDonalds"
        expect(page).to have_content "Food was OK"
      end

      it "should display the most recent review on the homepage" do
        visit '/restaurants'
        expect(page).to have_css '.recent-comments', :text => "Food was OK"
      end

      it "ranks restaurants by average rating" do
        kfc = Restaurant.create(name: 'KFC')
        kfc.reviews.create(rating: 5, comment: 'Amazing!')
        visit '/restaurants'
        expect(page).to have_css 'table tr:nth-of-type(1) td:nth-of-type(1)', :text => "KFC"
        expect(page).to have_css 'table tr:nth-of-type(2) td:nth-of-type(1)', :text => "McDonalds"
      end
    end
  end

end