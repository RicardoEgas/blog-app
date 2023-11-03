require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#update_likes_counter' do
    before :all do
      @user = User.create(name: 'David Beckham', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Poland.')
      @post = Post.create(author: @user, title: 'Hello World', text: 'I love coding', comments_counter: 0,
                          likes_counter: 0)
    end

    after :all do
      10.times { Like.create(user: @user, post: @post) }
    end

    it 'keeps track of likes and equals 10' do
      expect(@post.reload.likes_counter).to eq 10
    end
  end
end