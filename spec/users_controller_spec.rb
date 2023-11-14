require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    before(:each) do
      get '/users'
    end

    it 'should return the correct status' do
      expect(response.status).to eq(200)
    end
    it 'should render the correct template' do
      expect(response).to render_template('index')
    end
    it 'should include the correct placeholder' do
      expect(response.body).to include('Select User')
    end
  end

  describe 'GET /show' do
    before(:each) do
      @user = User.create(name: 'Ricardo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Web Developer')
      get user_path(id: @user.id)
    end

    it 'should return the correct status' do
      expect(response.status).to eq(200)
    end
    it 'should render the correct template' do
      expect(response).to render_template('show')
    end
    it 'should include the correct placeholder' do
      expect(response.body).to include('See all posts')
    end
  end
end
