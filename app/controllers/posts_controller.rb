class PostsController < ApplicationController
  include Htnb
  require 'rss'
  require 'open-uri'

  before_action :set_post, only: [:show, :update, :destroy]
  before_action :fetch_feed, only: [:fetch, :fetch_and_post]

  def fetch
    render json: @feeds
  end

  def fetch_and_post
    not_yet_post_items = extract_not_yet_post_items(Post.last_url, @feeds)
    render json: post(not_yet_post_items)
  end

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def post_params
    params.require(:post).permit(:title, :url, :comment)
  end

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
    if already_post_index
      feeds.values_at(Range.new(0, already_post_index - 1))
    else
      feeds
    end
  end
end
