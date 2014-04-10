FactoryGirl.define do
  factory :user do
    email                   'a@a.com'
    password                '123456789'
    password_confirmation   '123456789'
  end

  # Restaurants
  factory :restaurant do
    name                    'McDonalds'
    category                'Fast Food'
    location                'London'
  end

  factory :another_restaurant, class: Restaurant do
    name                    'KFC'
    category                'Fast Food'
    location                'London'
  end

  # Reviews
  factory :bad_review, class: Review do
    association :restaurant, factory: :restaurant
    rating                  '1'
    comment                 "Terrible!"
  end

  factory :great_review, class: Review do
    association :restaurant, factory: :another_restaurant
    rating                  '5'
    comment                 "Amazing!"
  end

end