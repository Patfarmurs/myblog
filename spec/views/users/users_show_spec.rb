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
      User.find_by(photo: 'https://unsplash.com/photos/F_-0BxGuVvo')
      expect(page).to have_content('4') 
    end

    it 'displays bio for a user' do
      User.find_by(bio: 'Teacher from Mexico.')
      expect(page).to have_content('Teacher from Mexico.')
    end

    it 'shows user first three posts' do
      expect(page).to have(post[1].text)
      expect(page).to have_text(posts[2].text)
      expect(page).to have_text(posts[3].text)
    end

    it "redirects me to the post's show page when i click a user's post" do  
      user = User.find_by(name: 'Tom')
      post = Post.find_by(title: 'This is my second post')
      click_on 'This is my second post'
      expect(page).to have_current_path(user_post_path(user.id, post.id))
    end
    it 'should have a button to see all posts' do
      User.find_by(name: 'Tom')
      expect(page).to have_link('See all posts')
    end
  end
end
