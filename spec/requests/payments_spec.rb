require 'rails_helper'

RSpec.describe 'Payments', type: :request do
  before(:each) do
    @user = User.create!(id: 2, name: 'becky', email: 'becky@mail.com', password: 'abcxyz123', confirmed_at: Time.now)
    # rubocop:disable Layout/LineLength

    @category = Category.create(user_id: @user.id,
                                icon: 'https://msn.engineering.asu.edu/wp-content/uploads/sites/17/2022/02/systems-engineering-phd-3x2-hero.jpg', name: 'Chicken')
    # rubocop:enable Layout/LineLength

    @payment = Payment.create(name: 'pliers', amount: 20, author: @user)
    @payment_category = PaymentCategory.create(payment: @payment, category: @category)
    sign_in @user
  end
  describe 'GET /categories/:category_id/payments' do
    it 'returns a successful response' do
      get category_payments_path(@category)
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get category_payments_path(@category)
      expect(response).to render_template(:index)
    end
    it 'includes correct placeholder text in the response body' do
      get category_payments_path(@category)
      expect(response.body).to include('Transactions')
    end
  end
  describe 'GET   /categories/:category_id/payments/new' do
    it 'should be response successfull' do
      get new_category_payment_path(@category)
      expect(response).to have_http_status(:ok)
    end

    it 'should render the new file' do
      get new_category_payment_path(@category)
      expect(response).to render_template(:new)
    end


    it 'should include the placeholder' do
      get new_category_path(@category)
      expect(response.body).to include('New Transaction')
    end
  end
  describe 'POST /create' do
    it 'should create a new payment' do
      post category_payments_path(@category),
           params: { payment: { amount: 200, name: 'nails' } }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(category_payments_path(@category))
      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Transactions')
    end

    it 'should render new template on invalid data' do
      post category_payments_path(@category),
           params: { payment: { amount: nil, name: nil } }
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end
end
