require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.new(name: 'Richard', bio: 'Teacher from Mexico.', posts_counter: 0)
  subject do
    Post.new(author: user, title: 'Hello', text: 'This is my first post', likes_counter: 0, comments_counter: 0)
  end

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be greater than or equal to zero' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be greater than or equal to zero' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'subject should be valid' do
    expect(subject).to be_valid
  end
end
