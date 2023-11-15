require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'after_save callbacks' do
    let(:user) { User.create(name: 'John Doe', post_counter: 0) }
    let(:post) { Post.create(title: 'Test Post', author: user) }
    let(:comment) { Comment.create(author: user, post:) }

    it 'updates the post comment counter after creating a comment' do
      expect { comment.save }.to change { post.reload.comment_counter }.by(1)
    end
  end
end
