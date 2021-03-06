class PostsController < ApplicationController
  include Htnb
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  require 'rss'
  require 'open-uri'

  before_action :fetch_feed, only: [:fetch, :fetch_and_post]
  http_basic_authenticate_with name: ENV['BASIC_AUTH_ID'], password: ENV['BASIC_AUTH_PW']

  def fetch
    render json: @feeds
  end

  def fetch_and_post
    not_yet_post_items = extract_not_yet_post_items(Post.last_url, @feeds)
    (render json: []; return) if not_yet_post_items.empty?
    Post.last_url = not_yet_post_items.first[:url]
    render json: post(not_yet_post_items)
  end

  private

  def fetch_feed
    url = 'http://b.hatena.ne.jp/dogwood008/rss'
    ua = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36'
    rss = open(url, 'User-Agent' => ua)
    feed = RSS::Parser.parse(rss)
    rss.close
    @feeds = feed.items.map do |i|
      { url: i.link, title: i.title, comment: i.description, date: i.dc_date }
    end
  end

  def get_already_post_index(already_post_url, feeds)
    feeds.index { |f| f[:url] == already_post_url }
  end

  def extract_not_yet_post_items(already_post_url, feeds)
    already_post_index = get_already_post_index(already_post_url, feeds)
    already_post_index ? feeds[0, already_post_index] : feeds
  end
end
