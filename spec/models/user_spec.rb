# user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates presence of name' do
    user = User.new(name: 'John Doe', post_counter: 0)
    expect(user).to be_valid
  end

  it 'validates posts_counter is a non-negative integer' do
    user = User.new(name: 'John Doe', post_counter: -1)
    expect(user).not_to be_valid
  end

  describe '#recent_posts' do
    it 'returns the most recent post' do
      user = User.create(name: 'Example User', photo: 'example.jpg', bio: 'Example bio')
      Post.create(author: user, title: 'Post 1', text: 'hello world')
      Post.create(author: user, title: 'Post 2', text: 'hello world')
      post3 = Post.create(author: user, title: 'Post 3', text: 'hello world')

      rec_posts = user.recent_posts
      most_recent_post = rec_posts.first

      expect(most_recent_post).to eq(post3)
    end
  end
end
