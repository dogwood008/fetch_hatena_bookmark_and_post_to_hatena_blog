class Post < ApplicationRecord
  def self.contains_by_post_date?(post_date)
    Post.find_by_date(post_date)
  end
end
