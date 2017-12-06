require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create :user }
  let(:post) { build :post, user: user }

  it 'is valid with valid attributes' do
    expect(post).to be_valid
  end

  it 'is not valid without a user' do
    post.user = nil
    expect(post).to be_invalid
  end

  it 'is not valid without a title' do
    post.title = nil
    expect(post).to be_invalid
  end

  it 'is not valid without a url' do
    post.url = nil
    expect(post).to be_invalid
  end
end
