require 'rails_helper'

RSpec.describe 'User index', type: :feature do
  before :each do
    @user1 = User.create(name: 'Patrick', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'web developer',
                         post_counter: 0)
    @user2 = User.create(name: 'Mike', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'web developer',
                         post_counter: 0)
    @user3 = User.create(name: 'Bob', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'web developer',
                         post_counter: 0)
    visit '/users'
  end

  it 'shows the correct content' do
    expect(page).to have_content('Select User')
    expect(page).to have_content('Mike')
    expect(page).to have_content('Bob')
  end

  it 'shows the number of posts each user has written' do
    expect(page).to have_content('Number of posts')
    expect(page).to have_text("Mike\nNumber of posts: 0")
    expect(page).to have_text("Bob\nNumber of posts: 0")
  end

  it 'click on a user and it should redirect to user/show page' do
    click_on 'Patrick'
    expect(page).to have_content 'Patrick'
    expect(current_path).to eq(user_path(@user1))
  end

  it 'should return the correct css ' do
    expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
  end
end
