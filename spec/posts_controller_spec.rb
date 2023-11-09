require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before(:each) do
      get '/users/1/posts'
    end

    it 'should return the correct status' do
      expect(response.status).to eq(200)
    end

    it 'should render the correct template' do
      expect(response).to render_template('index')
    end

    it 'should include the correct placeholder' do
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  describe 'GET /show' do
    before(:each) do
      get '/users/1/posts/1'
    end

    it 'should return the correct status' do
      expect(response.status).to eq(200)
    end

    it 'should render the correct template' do
      expect(response).to render_template('show')
    end

    it 'should return the correct placeholder' do
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end
end
