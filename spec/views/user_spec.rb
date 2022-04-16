require 'rails_helper'

RSpec.describe 'User', type: :feature do
  before :all do
    @first_user = User.find_by(email: 'jane@example.com')
    @second_user = User.find_by(email: 'john@example.com')
    @third_user = User.find_by(email: 'tomdoe@example.com')

    if @first_user.nil?
      @first_user = User.create(name: 'Jane Doe', photo: 'no-photo.jpg', bio: 'Farmer', password: '123456',
                                email: 'jane@example.com', confirmed_at: '2022-04-16 10:14:43.057417')
    end

    if @second_user.nil?
      @second_user = User.create(name: 'John Doe', photo: 'no-photo.jpg', bio: 'Programmer', password: '123456',
                                 email: 'john@example.com', confirmed_at: '2022-04-16 10:14:43.057417')
    end

    if @third_user.nil?
      @third_user = User.create(name: 'Tom Doe', photo: 'no-photo.jpg', bio: 'Businessman', password: '123456',
                                email: 'tomdoe@example.com', confirmed_at: '2022-04-16 10:14:43.057417')
    end
  end

  describe 'index' do
    before :all do
      @first_user = User.find_by(name: 'Jane Doe')
      @second_user = User.find_by(name: 'John Doe')
      @third_user = User.find_by(name: 'Tom Doe')

      if @first_user.nil?
        @first_user = User.create(name: 'Jane Doe', photo: 'no-photo.jpg', bio: 'Farmer', password: '123456',
                                  email: 'jane@example.com', confirmed_at: '2022-04-16 10:14:43.057417')
      end

      if @second_user.nil?
        @second_user = User.create(name: 'John Doe', photo: 'no-photo.jpg', bio: 'Programmer', password: '123456',
                                   email: 'john@example.com', confirmed_at: '2022-04-16 10:14:43.057417')
      end

      if @third_user.nil?
        @third_user = User.create(name: 'Tom Doe', photo: 'no-photo.jpg', bio: 'Businessman', password: '123456',
                                  email: 'tom@example.com', confirmed_at: '2022-04-16 10:14:43.057417')
      end
    end

    before :each do
      visit '/'
    end

    it 'shows the names of all users' do
      expect(page).to have_content('Jane Doe')
      expect(page).to have_content('John Doe')
      expect(page).to have_content('Tom Doe')
    end

    it 'See the profile picture for each user' do
      all_images = page.all('img')
      expect(all_images.count).to eq(User.all.count)
    end

    it 'See the number of posts each user has written' do
      expect(page).to have_content('Posts: 0')
    end

    it 'When I click on a user, I am redirected to that user\'s show page.' do
      click_link 'Tom Doe'
      expect(page).to have_current_path(user_path(@third_user.id))
    end
  end

  describe 'show' do
    before :each do
      visit new_user_session_path
      fill_in 'Email', with: 'jane@example.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'

      @post1 = Post.find_by(title: 'Post #1')
      @post2 = Post.find_by(title: 'Post #2')
      @post3 = Post.find_by(title: 'Post #3')

      if @post1.nil?
        @post1 = Post.create(author: @first_user, title: 'Post #1', text: 'Post #1', comments_counter: 0,
                             likes_counter: 0)
      end

      if @post2.nil?
        @post2 = Post.create(author: @first_user, title: 'Post #2', text: 'Post #2', comments_counter: 0,
                             likes_counter: 0)
      end

      if @post3.nil?
        @post3 = Post.create(author: @first_user, title: 'Post #3', text: 'Post #3', comments_counter: 0,
                             likes_counter: 0)
      end
    end

    before :each do
      visit "/users/#{@first_user.id}"
    end

    it 'I can see the user\'s profile picture' do
      all_images = page.all('img')
      expect(all_images.count).to eq(1)
    end

    it 'shows the correct path' do
      expect(page).to have_current_path("/users/#{@first_user.id}")
    end

    it 'shows the user username' do
      expect(page.find('h3', text: 'Jane Doe')).to be_truthy
    end

    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content("Posts: #{@first_user.posts.count}")
    end

    it 'I can see the user\'s bio.' do
      expect(page).to have_content(@first_user.bio)
    end

    it 'I can see the user\'s first 3 posts.' do
      expect(page.find_all('div', class: ['post-title']).count).to eq(3)
    end

    it 'When I click a user\'s post, it redirects me to that post\'s show page' do
      click_link @post1.title
      expect(page).to have_current_path("/users/#{@post1.user_id}/posts/#{@post1.id}")
    end

    it 'When I click to see all posts, it redirects me to the user\'s post\'s index page.' do
      click_link @post1.title
      expect(page).to have_current_path(user_post_path(@first_user, @post1))
    end
  end
end
