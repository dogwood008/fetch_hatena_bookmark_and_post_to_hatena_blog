class Post < ApplicationRecord
  def self.last_url
    Post.first&.url
  end
end
