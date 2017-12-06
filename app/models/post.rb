# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  url        :string
#  created_at :datetime
#  user_id    :integer
#

class Post < ApplicationRecord
  belongs_to :user

  validates_presence_of :title, :url
end
