require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  before(:each) do
    @user = User.create!(id: 2, name: 'becky', email: 'becky@mail.com', password: 'abcxyz123', confirmed_at: Time.now)
    # rubocop:disable Layout/LineLength
    @category = Category.create(user_id: @user.id,
                                icon: 'https://msn.engineering.asu.edu/wp-content/uploads/sites/17/2022/02/systems-engineering-phd-3x2-hero.jpg', name: 'Chicken')
    # rubocop:enable Layout/LineLength

    sign_in @user
  end
  describe 'GET /categories' do
    it 'returns a successful response' do
      get categories_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get categories_path
      expect(response).to render_template(:index)
    end
    it 'includes correct placeholder text in the response body' do
      get categories_path
      expect(response.body).to include('Categories')
    end
  end
  describe 'GET /new' do
    it 'should be response successfull' do
      get new_category_path
      expect(response).to have_http_status(:ok)
    end

    it 'should render the new file' do
      get new_category_path
      expect(response).to render_template(:new)
    end


    it 'should include the placeholder' do
      get new_category_path
      expect(response.body).to include('New Category')
    end
  end
  describe 'POST /create' do
    it 'should create a new category' do
      post categories_path,
           params: { category: { icon: 'https://msn.engineering.asu.edu/wp-content/uploads/sites/17/2022/02/systems-engineering-phd-3x2-hero.jpg', name: 'Engineering' } }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(categories_path)
      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Categories')
    end

    it 'should render new template on invalid data' do
      post categories_path,
           params: { category: { icon: nil, name: nil } }
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end
end
