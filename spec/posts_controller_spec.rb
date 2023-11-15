require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before(:each) do
      @user = User.create(name: 'Ricardo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Web Developer')
      get user_posts_path(@user.id)
    end

    it 'should return the correct status' do
      expect(response.status).to eq(200)
    end

    it 'should render the correct template' do
      expect(response).to render_template('index')
    end

    it 'should include the correct placeholder' do
      expect(response.body).to include('Ricardo')
    end
  end

  describe 'GET /show' do
    before(:each) do
      @user = User.create(name: 'Ricardo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Web Developer')
      @post = Post.create(title: 'test', author_id: @user.id, text: 'test')
      get user_post_path(user_id: @user.id, id: @post.id)
    end

    it 'should return the correct status' do
      expect(response.status).to eq(200)
    end

    it 'should render the correct template' do
      expect(response).to render_template('show')
    end

    it 'should return the correct placeholder' do
      expect(response.body).to include('Ricardo')
    end
  end
end
