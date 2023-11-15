require 'rails_helper'
RSpec.describe 'Post index ' do
  before :each do
    @user = User.create(name: 'Ricardo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                        post_counter: 0)
    @post1 = Post.create(author_id: @user.id, title: 'Hello', text: 'first post', like_counter: 0,
                         comment_counter: 0)
    @post2 = Post.create(author_id: @user.id, title: 'World', text: 'second post', like_counter: 0,
                         comment_counter: 0)
    @post3 = Post.create(author_id: @user.id, title: '!', text: 'third post', like_counter: 0,
                         comment_counter: 0)
    @comment = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'first comment')
    visit user_posts_path(@user)
  end
  it 'see the user profile picture' do
    expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
  end
  it ' can see the user name' do
    expect(page).to have_content('Ricardo')
  end
  it 'can see the number of posts user has written' do
    expect(page).to have_content('Number of posts: 3')
  end
  it 'can see a post title' do
    visit user_post_path(@user.id, @post1.id)
    expect(page).to have_content('Hello')
  end
  it 'can see some of post body' do
    visit user_post_path(@user.id, @post1.id)
    expect(page).to have_content('first post')
  end
  it 'can see first comment on post ' do
    visit user_post_path(@user.id, @post1.id)
    expect(page).to have_content('first comment')
  end
  it 'can see how many comment has' do
    visit user_post_path(@user.id, @post1.id)
    expect(page).to have_content('Comments: 1')
  end
  it ' can see how many likes a post has ' do
    visit user_post_path(@user.id, @post1.id)
    expect(page).to have_content('Likes: 0')
  end
  it 'can see section for pagination  if there are more posts than fit on the view. ' do
    expect(page).to have_css('.pagination')
  end
  it "When I click on a post, it redirects me to that post's show page." do
    visit user_post_path(@user.id, @post1.id)
    within('.post-container') do
      find('h2', text: 'Hello').click
    end
    expect(page).to have_content('Hello')
  end
end
