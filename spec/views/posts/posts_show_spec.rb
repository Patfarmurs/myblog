require 'rails_helper'

RSpec.describe 'User', type: :feature, js: false do
  before :each do
    @user = User.create(name: 'Tom', photo: 'https://randomuser.me/api/portraits/men/2.jpg',
                        bio: 'Teacher in Mexico')
    @first_post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')
    @comment = Comment.create(post: @first_post, author: @user, text: 'Hi Tom!')

    visit "/users/#{@user.id}/posts"
  end

  describe 'Post page' do
    it "shows the user's profile" do
      expect(page).to have_css("img[src*='https://randomuser.me/api/portraits/men/2.jpg']")
    end

    it "shows the user's username" do
      user_name = Post.find_by(author: @user.name)
      expect(page).to have_content(user_name)
    end

    it 'shows the title of the post' do
      expect(page).to have_content('Hello')
    end

    it 'show who wrote the post' do
      expect(page).to have_content(@user.name)
    end

    it 'show comment each commentor left' do
      expect(page).to have_content(@comment.text)
    end

    it 'shows the body of the post' do
      expect(page).to have_content('This is my first post')
    end

    it 'shows the number of likes && comments of the post' do
      user_post = @user.posts.find_by(id: @first_post.id)
      expect(page).to have_content(user_post.comments.count)
      expect(page).to have_content(user_post.likes.count)
    end
  end
end
