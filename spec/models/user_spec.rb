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
    it 'returns the 3 most recent posts' do
      user = User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                         bio: 'Teacher from Poland.')
      post1 = Post.create(author: user, title: 'Post 1', text: 'hello world', comments_counter: 0,
                          likes_counter: 0, created_at: 2.days.ago)
      post2 = Post.create(author: user, title: 'Post 2', text: 'hello world', comments_counter: 0,
                          likes_counter: 0, created_at: 2.days.ago)
      post3 = Post.create(author: user, title: 'Post 3', text: 'hello world', comments_counter: 0,
                          likes_counter: 0, created_at: 2.days.ago)
      rec_posts = user.recent_posts
      expect(rec_posts).to eq([post3, post2, post1])
    end
  end
end
