require 'rails_helper'

RSpec.describe 'User show', type: :feature do
  before :each do
    @user = User.create(name: 'Ricardo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'web developer',
                        post_counter: 0)
    @post1 = Post.create(author_id: @user.id, title: 'Hello', text: 'first post', like_counter: 0,
                         comment_counter: 0)
    @post2 = Post.create(author_id: @user.id, title: 'World', text: 'second post', like_counter: 0,
                         comment_counter: 0)
    @post3 = Post.create(author_id: @user.id, title: '!', text: 'third post', like_counter: 0,
                         comment_counter: 0)
    visit user_path(@user.id)
  end

  it 'see the user profile picture' do
    expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
  end

  it 'see the user profile name' do
    expect(page).to have_content 'Ricardo'
  end

  it 'see the number of posts user has written' do
    expect(page).to have_content 'Number of posts: 3'
  end

  it 'see the user bio ' do
    expect(page).to have_content 'web developer'
  end

  it 'see the user first three posts ' do
    expect(page).to have_content('first post')
    expect(page).to have_content('second post')
    expect(page).to have_content('third post')
  end

  it 'see the button that let me view all users posts' do
    expect(page).to have_link('See all posts')
  end

  it "When I click a user's post, it redirects me to that post's show page." do
    click_on 'Hello'
    expect(page).to have_content 'first post'
    expect(current_path).to eq(user_post_path(@user, @post1))
  end

  it " When I click to see all posts, it redirects me to the user's post's index page. " do
    click_on 'See all posts'
    expect(page).to have_content "Ricardo's Posts"
  end
end
