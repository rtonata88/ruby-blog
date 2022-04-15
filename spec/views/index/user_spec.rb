require 'rails_helper'

RSpec.describe 'User', type: :feature do
  before :all do
    @first_user = User.find_by(name: 'Jane Doe')
    @second_user = User.find_by(name: 'John Doe')
    @third_user = User.find_by(name: 'Tom Doe')

    if @first_user.nil?
      @first_user = User.create(name: 'Jane Doe', photo: 'no-photo.jpg', bio: 'Farmer', password: '123456',email: 'jane@example.com')
    end

    if @second_user.nil?
      @second_user = User.create(name: 'John Doe', photo: 'no-photo.jpg', bio: 'Programmer', password: '123456',email: 'john@example.com')
    end

    if @third_user.nil?
      @third_user = User.create(name: 'Tom Doe', photo: 'no-photo.jpg', bio: 'Businessman', password: '123456',email: 'tom@example.com')
    end
  end

  describe 'index' do
    before :all do
      @first_user = User.find_by(name: 'Jane Doe')
      @second_user = User.find_by(name: 'John Doe')
      @third_user = User.find_by(name: 'Tom Doe')

      if @first_user.nil?
        @first_user = User.create(name: 'Jane Doe', photo: 'no-photo.jpg', bio: 'Farmer', password: '123456',email: 'jane@example.com')
      end

      if @second_user.nil?
        @second_user = User.create(name: 'John Doe', photo: 'no-photo.jpg', bio: 'Programmer', password: '123456',email: 'john@example.com')
      end

      if @third_user.nil?
        @third_user = User.create(name: 'Tom Doe', photo: 'no-photo.jpg', bio: 'Businessman', password: '123456',email: 'tom@example.com')
      end
    end

    before :each do
      visit "/"
    end

    it 'shows the names of all users' do
      expect(page).to have_content('Jane Doe')
      expect(page).to have_content('John Doe')
      expect(page).to have_content('Tom Doe')
    end

    it 'See the profile picture for each user' do
      all_images = page.all('img')
      expect(all_images.count).to eq(3)
    end

    it 'See the number of posts each user has written' do
      expect(page).to have_content('Posts: 0')
    end

    it 'When I click on a user, I am redirected to that user\'s show page.' do
      click_link 'Tom Doe'
      expect(page).to have_current_path(user_path('3'))
    end
  end

  describe 'show' do
    before :each do
      visit new_user_session_path
      fill_in 'Email', with: 'john@example.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'

      if @first_user.posts.count < 3
        unless @first_user.posts.find_by(title: 'Post title 1')
          @post1 = @first_user.posts.create!(title: 'Post title 1',
                                             text: 'Post text 1')
        end
        @post2 = @first_user.posts.create!(title: 'Post title 2', text: 'Post text 2')
        @post3 = @first_user.posts.create!(title: 'Post title 3', text: 'Post text 3')
      end
      @post1 = @first_user.posts.find(1)
      @post2 = @first_user.posts.find(2)
      @post3 = @first_user.posts.find(3)
      click_link 'Tom'
    end

    it 'shows the correct path' do
      expect(page).to have_current_path(user_path(@first_user))
    end

    it 'shows the user profile picture' do
      all_images = page.all('img')
      expect(all_images.count).to eq(1)
    end

    it 'shows the user username' do
      expect(page.find('h4', text: 'Tom')).to be_truthy
    end

    it 'shows the user post count' do
      expect(page).to have_content("Posts: #{@first_user.posts.count}")
    end

    it 'shows the user bio' do
      expect(page).to have_content(@first_user.bio)
    end

    it 'shows the user\'s first three posts' do
      expect(page.find_all('div', class: 'post-card').count).to eq(3)
    end

    it 'shows the user\'s posts when any post is clicked' do
      click_link @post1.title
      expect(page).to have_current_path(user_posts_path(@first_user))
    end

    it 'shows the post details when any post is clicked in the post index page' do
      click_link @post1.title
      click_link @post1.title
      expect(page).to have_current_path(user_post_path(@first_user, @post1))
    end
  end
end
