require 'rails_helper'

RSpec.describe 'categories/new', type: :feature do
  before(:each) do
    @user = User.create!(id: 2,
                         name: 'becky',
                         email: 'becky@mail.com',
                         password: 'abcxyz123',
                         confirmed_at: Time.now)
    # rubocop:disable Layout/LineLength
    @category1 = @user.categories.create!(
      icon: 'https://msn.engineering.asu.edu/wp-content/uploads/sites/17/2022/02/systems-engineering-phd-3x2-hero.jpg', name: 'Chicken'
    )
    # rubocop:enable Layout/LineLength
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit new_category_payment_path(@category1)
  end

  scenario 'displays new Category form' do
    expect(page).to have_content('New Transaction')
    expect(page).to have_field('payment_name', type: 'text')
    expect(page).to have_field('payment_amount', type: 'text')
    expect(page).to have_button('Save', class: 'submit-button')
  end

  scenario 'creates a new Transaction' do
    fill_in 'payment_name', with: 'chicken tikka'
    fill_in 'payment_amount', with: 50

    click_button 'Save'

    expect(page).to have_content('chicken tikka')
  end
end
