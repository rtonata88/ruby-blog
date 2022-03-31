require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET user_posts' do
    it 'renders the posts index template' do
      get '/users/:user_id/posts'
      expect(response).to render_template('index')
    end

    it 'returns a 200 OK status' do
      get '/users/:user_id/posts'
      expect(response).to have_http_status(:ok)
    end

    it 'returns the correct text' do
      get '/users/:user_id/posts'
      expect(response.body).to include('Posts index goes here')
    end
  end

  describe 'GET user_post' do
    it 'renders the show template' do
      get '/users/:user_id/posts/:id'
      expect(response).to render_template('show')
    end

    it 'returns the correct text' do
      get '/users/:user_id/posts/:id'
      expect(response.body).to include('Show posts goes here')
    end
  end
end
