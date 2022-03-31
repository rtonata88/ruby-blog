require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET users' do
    it 'renders the users index template' do
      get '/users'
      expect(response).to render_template('index')
    end

    it 'returns a 200 OK status' do
      get '/users'
      expect(response).to have_http_status(:ok)
    end

    it 'returns the correct text' do
      get '/users'
      expect(response.body).to include('List of users goes here')
    end
  end

  describe 'GET user' do
    it 'renders the show template' do
      get '/users/:id'
      expect(response).to render_template('show')
    end

    it 'returns the correct text' do
      get '/users/:id'
      expect(response.body).to include('User posts goes here')
    end
  end
end
