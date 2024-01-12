require 'rails_helper'

RSpec.describe 'categories/index', type: :feature do
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
    @category2 = @user.categories.create!(
      icon: 'https://msn.engineering.asu.edu/wp-content/uploads/sites/17/2022/02/systems-engineering-phd-3x2-hero.jpg', name: 'Toys'
    )
    # rubocop:enable Layout/LineLength

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit categories_path
  end

  scenario 'displays user\'s categories' do
    expect(page).to have_content(@category1.name)
    expect(page).to have_content(@category2.name)
    expect(page).to have_link('Add Category')
  end
end
