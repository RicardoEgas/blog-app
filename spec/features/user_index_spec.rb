require 'rails_helper'

RSpec.describe 'User index', type: :feature do
  before :each do
    @user = User.create(name: 'Patrick', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'web developer',
                        post_counter: 0)
    visit '/users'
  end

  it 'shows the correct content' do
    expect(page).to have_content('Select User')
  end

  it 'shows the number of posts each user has written' do
    expect(page).to have_content('Number of posts')
  end

  it 'click on a user and it should redirect to user/show page' do
    click_on 'Patrick'
    expect(page).to have_content 'Patrick'
  end

  it 'should return the correct css ' do
    expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
  end
end
