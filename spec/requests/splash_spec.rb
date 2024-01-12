require 'rails_helper'

RSpec.describe 'Splash', type: :request do
  describe 'GET /' do
    it 'returns a successful response' do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get root_path
      expect(response).to render_template(:index)
    end
    it 'includes correct placeholder text in the response body' do
      get root_path
      expect(response.body).to include('Financier')
    end
  end
end
