require 'rails_helper'
RSpec.describe 'Post show' do
  before :each do
    @user = User.create(name: 'Ricardo', photo: 'https://picsum.photos/id/23/200', bio: 'web developer',
                        post_counter: 0)
    @post1 = Post.create(author_id: @user.id, title: 'Hello', text: 'first post', like_counter: 0,
                         comment_counter: 0)
    @post2 = Post.create(author_id: @user.id, title: 'World', text: 'second post', like_counter: 0,
                         comment_counter: 0)
    @post3 = Post.create(author_id: @user.id, title: '!', text: 'third post', like_counter: 0,
                         comment_counter: 0)
    @comment1 = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'first comment')
    @comment2 = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'second comment')

    visit user_post_path(@user.id, @post1.id)
  end
  it 'see the post title' do
    expect(page).to have_content('Hello')
  end
  it 'see who wrote the post' do
    expect(page).to have_content('Ricardo')
  end
  it 'see how many comments it has' do
    expect(page).to have_content('Comments: 2')
  end
  it 'see how many likes it has' do
    expect(page).to have_content('Likes: 0')
  end
  it 'see the post body' do
    expect(page).to have_content('first post')
  end
  it 'see the username of each commentor' do
    expect(page).to have_content(@comment1.author.name)
    expect(page).to have_content(@comment2.author.name)
  end
  it 'see the comment of each commentor left' do
    expect(page).to have_content(@comment1.text)
    expect(page).to have_content(@comment2.text)
  end
end
