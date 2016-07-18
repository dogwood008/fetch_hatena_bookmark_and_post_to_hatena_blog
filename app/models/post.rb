class Post < ApplicationRecord
  def self.last_url
    Post.first&.url
  end

  def self.last_url=(url)
    Post.first.update_attributes(url: url)
  end
end
