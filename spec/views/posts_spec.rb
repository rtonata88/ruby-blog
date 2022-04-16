require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  before :all do
    @first_user = User.find_by(name: 'Jane Doe')

    if @first_user.nil?
      @first_user = User.create(name: 'Jane Doe', photo: 'no-photo.jpg', bio: 'Farmer', password: '123456',
                                email: 'jane@example.com')
    end

    visit new_user_session_path
    fill_in 'Email', with: 'jane@example.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'

    @post1 = Post.find_by(title: 'Post #1')

    if @post1.nil?
      @post1 = Post.create(author: @first_user, title: 'Post #1', text: 'Post #1', comments_counter: 0,
                           likes_counter: 0)
    end

    if @post.comments.empty?
      @comment1 = @post.comments.create(text: 'Comment text 1', user_id: @first_user.id)
      @comment2 = @post.comments.create(text: 'Comment text 2', user_id: @first_user.id)
    else
      @comment1 = @post.comments.find(1)
      @comment2 = @post.comments.find(2)
    end
  end

  describe 'index' do
    before :each do
      visit user_posts_path(@first_user)
    end

    it 'See the profile picture for each user' do
      all_images = page.all('img')
      expect(all_images.count).to eq(1)
    end

    it 'See the user\'s username' do
      expect(page).to have_content('Tom')
    end

    it 'See the number of posts each user has written' do
      expect(page).to have_content("Posts: #{@first_user.posts.count}")
    end

    it 'See the post title' do
      expect(page).to have_content(@post.title)
    end

    it 'See the post body' do
      expect(page).to have_content(@post.text)
    end

    it 'See the first comments on a post.' do
      # expect(page).to have_current_path user_posts_path(@first_user)
      expect(page).to have_content('Comment text 1')
    end

    it 'See how many comments a post has.' do
      expect(page.find_all('ul.post-comments li').count).to eq(5)
    end

    it 'See how many likes a post has.' do
      expect(page).to have_content("Likes: #{@post.likes.count}")
    end

    it 'Shows the post details when any post is clicked in the post show page' do
      click_link @post.title
      expect(page).to have_current_path(user_post_path(@first_user, @post))
    end
  end

  describe 'show' do
    before :each do
      visit user_post_path(@first_user, @post)
    end

    it 'shows the correct path' do
      expect(page).to have_current_path(user_post_path(@first_user, @post))
    end

    it 'See the post title' do
      expect(page).to have_content(@post.title)
    end

    it 'shows who wrote the post' do
      expect(page).to have_content(@post.author.name)
    end

    it 'shows how many comments the post has' do
      expect(page).to have_content("Comments: #{@post.comments.count}")
    end

    it 'shows how many likes the post has' do
      expect(page).to have_content("Likes: #{@post.likes.count}")
    end

    it 'shows the post body' do
      expect(page).to have_content(@post.text)
    end

    it 'shows who wrote the comment' do
      expect(page).to have_content("#{@comment1.author.name}:   #{@comment1.text}")
    end
  end
end
