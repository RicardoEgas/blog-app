require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John Doe', post_counter: 0) }
  let(:post) { user.posts.create(title: 'Sample Post') }

  it 'is valid with valid attributes' do
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    post.title = nil
    expect(post).not_to be_valid
  end

  it 'is not valid with a title exceeding 250 characters' do
    post.title = 'a' * 251
    expect(post).not_to be_valid
  end

  it 'is valid with non-negative comments_counter' do
    post.comments_counter = 1
    expect(post).to be_valid
  end

  it 'is not valid with negative comments_counter' do
    post.comments_counter = -1
    expect(post).not_to be_valid
  end

  it 'is valid with non-negative likes_counter' do
    post.likes_counter = 1
    expect(post).to be_valid
  end

  it 'is not valid with negative likes_counter' do
    post.likes_counter = -1
    expect(post).not_to be_valid
  end

  describe '#recent_comments' do
    it 'returns up to 5 most recent comments' do
      user = User.create(name: 'John Doe', post_counter: 0)
      post = user.posts.create(title: 'New Post')

      older_comment = post.comments.create(text: 'Older Comment', user_id: user.id, created_at: 2.days.ago)
      newer_comment = post.comments.create(text: 'Newer Comment', user_id: user.id, created_at: 1.day.ago)

      recent_comments = post.recent_comments

      expect(recent_comments).to include(newer_comment)
      expect(recent_comments).to include(older_comment)
      expect(recent_comments.size).to eq(2)
    end
  end

  describe '#update_post_counter' do
    it 'updates the author\'s post_counter after save' do
      user = User.create(name: 'John Doe', post_counter: 0)
      post = user.posts.build(title: 'New Post')

      expect { post.save }.to change { user.reload.post_counter }.by(1)
    end
  end
end
