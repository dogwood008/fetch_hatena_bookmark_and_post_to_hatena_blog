require 'hatenablog'

module Htnb
  extend ActiveSupport::Concern

  def post(entry_hash)
    post_from_array(convert_item_to_array(entry_hash))
  end

  private

  def convert_item_to_array(items)
    title = "#{today} マイトレンドニュース"
    body = make_markdown_body(items)
    category = [:test]
    draft = 'yes'
    [title, body, category, draft]
  end

  def make_markdown_body(items)
    items.inject('') { |str, i| str << "- [#{i[:title]}](#{i[:url]})\n  - #{i[:comment]}\n" }
  end

  def convert_entry_hash_to_array(hash)
    [hash[:title], hash[:body], hash[:category], hash[:draft] ? 'yes' : 'no']
  end

  def post_from_array(entry)
    Hatenablog::Client.create("#{Rails.root}/config/htn.yml.erb") do |blog|
      blog.post_entry(*entry)
    end
  end

  def today
    Time.zone.now.to_time.strftime('%y%m%d')
  end
end
