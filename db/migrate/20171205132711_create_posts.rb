class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.datetime :created_at
      t.integer :user_id
    end
  end
end
