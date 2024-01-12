require 'rails_helper'

RSpec.describe 'categories/new', type: :feature do
  before(:each) do
    @user = User.create!(id: 2,
                         name: 'becky',
                         email: 'becky@mail.com',
                         password: 'abcxyz123',
                         confirmed_at: Time.now)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit new_category_path
  end

  scenario 'displays new Category form' do
    expect(page).to have_content('New Category')
    expect(page).to have_field('category_name', type: 'text')
    expect(page).to have_field('category_icon', type: 'text')
    expect(page).to have_button('Save', class: 'submit-button')
  end

  scenario 'creates a new category' do
    fill_in 'category_name', with: 'Fruits'
    fill_in 'category_icon', with: 'https://msn.engineering.asu.edu/wp-content/uploads/sites/17/2022/02/systems-engineering-phd-3x2-hero.jpg'
    click_button 'Save'

    expect(page).to have_content('Fruits')
  end
end
