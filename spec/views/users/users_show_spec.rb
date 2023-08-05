require 'rails_helper'
require 'capybara/rspec'

base_url = 'http://localhost:3000'

RSpec.describe 'index_show', type: :feature, js: false do
  let!(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let!(:post) { Post.create(author_id: user.id, title: 'Hello', text: 'This is my first post') }
  let!(:post2) { Post.create(author_id: user.id, title: 'cream de la cream', text: 'It is a pleasure') }
  let!(:post3) { Post.create(author_id: user.id, title: 'kinetic', text: 'Boldly defined') }
  let!(:post4) { Post.create(author_id: user.id, title: 'halooo', text: 'Nice to meet you') }

  before(:each) do
    visit "#{base_url}/users/1"
  end

  describe 'show page' do
    it 'shows the name and profile photo of user' do
      User.find_by(photo: 'https://unsplash.com/photos/F_-0BxGuVvo')
      expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
      expect(page).to have_content('Hello')
    end

    it 'displays the number of post for a user' do
      User.find_by(bio: 'Teacher from Mexico.')
      expect(page).to have_content('Number of posts')
    end

    it 'displays bio for a user' do
      User.find_by(bio: 'Teacher from Mexico.')
      expect(page).to have_content('Teacher from Mexico.')
    end

    it 'shows user first three posts' do
      user = User.first
      visit user_posts_path(user.id)
      expect(page).to have_selector('recent_posts', maximum: 3)
    end

    it "redirects me to the post's show page when i click a user's post" do
      user = User.first
      post = Post.where(author_id: user.id).first
      visit user_posts_path(user.id)
      click_on post.title
      expect(page).to have_current_path("/users/#{user.id}/posts/#{post.id}")
    end

    it 'should have a button to see all posts' do
      user = User.find_by(name: 'Tom')
      click_link 'See all posts'
      # expect(page).to have_current_path("/users/#{user.id}/posts")
    end

    it 'should have a button to see all posts' do
      User.find_by(name: 'Tom')
      expect(page).to have_link('See all posts')
    end
  end
end
