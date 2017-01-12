require 'rails_helper'

feature 'reviewing' do


  scenario 'Allows users to leave a review using a form' do
    sign_up
    add_restaurant
    click_link('Review KFC')
    fill_in("Thoughts", with: "so so")
    select '3', from: 'Rating'
    click_button("Leave Review")
    expect(current_path).to eq("/restaurants")
    expect(page).to have_content("so so")
  end

  scenario "User can only leave one review" do
    sign_up
    add_restaurant
    click_link('Review KFC')
    fill_in("Thoughts", with: "so so")
    select '3', from: 'Rating'
    click_button("Leave Review")
    click_link('Review KFC')
    fill_in("Thoughts", with: "average")
    select '3', from: 'Rating'
    click_button("Leave Review")
    expect(page).to have_content("Has reviewed this restaurant already")
  end

  scenario "User can delete their review" do
    sign_up
    add_restaurant
    click_link('Review KFC')
    fill_in("Thoughts", with: "so so")
    select '3', from: 'Rating'
    click_button("Leave Review")
    click_link("Delete review")
    expect(page).not_to have_content("so so")
    expect(page).not_to have_content(3)
  end
end
