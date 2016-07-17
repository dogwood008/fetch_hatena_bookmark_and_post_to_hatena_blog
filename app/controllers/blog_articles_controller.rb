class BlogArticlesController < ApplicationController
  require 'hatenablog'

  def show
    Hatenablog::Client.create("#{Rails.root}/config/htn.yml.erb") do |blog|
      # Get each entry's content
      blog.entries.each do |entry|
        puts entry.content
      end
    end
  end

  def create
    entry = { title: 'title', body: 'body', category: [:test], draft: true }
    render json: post(entry)
  end

  private

  def post(entry_hash)
    post_from_array(convert_entry_hash_to_array(entry_hash))
  end

  def convert_entry_hash_to_array(hash)
    [hash[:title], hash[:body], hash[:category], hash[:draft] ? 'yes' : 'no']
  end

  def post_from_array(entry)
    Hatenablog::Client.create("#{Rails.root}/config/htn.yml.erb") do |blog|
      blog.post_entry(*entry)
    end
  end
end
