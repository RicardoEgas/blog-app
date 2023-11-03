require 'rails_helper'

RSpec.describe Like, type: :model do
  before :all do
    @author = User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Poland.')
    @user = User.create(name: 'David Beckham', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                        bio: 'Teacher from Poland.')
    @post = Post.create(author: @author, title: 'Hello World', text: 'I love coding', comments_counter: 0,
                        likes_counter: 0)
  end

  context '#update_likes_counter' do
    before :all do
      10.times { Like.create(user: @user, post: @post) }
    end

    it 'keeps track of likes and equals 10' do
      expect(@post.likes_counter).to eq 10
    end
  end
end
