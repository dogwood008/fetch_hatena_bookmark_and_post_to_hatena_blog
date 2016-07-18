# About this project

This Ruby on Rails project watch your hatena bookmark and post to your hatena blog when a GET access is catched. This only posts new entries before previous post.

この Ruby on Rails のプロジェクトは、GETアクセスがあった際にはてなブックマークを参照し、はてなブログに投稿します。履歴を保持しており、新しいもののみを投稿します。

# Environments

Set these variables as environments.

## Basic Auth

- BASIC_AUTH_ID
  - any
- BASIC_AUTH_PW
  - any

## hatena

- HTN_USER_ID
  - e.g.) dogwood008
- HTN_BLOG_ID
  - e.g.) dogwood008.hatenablog.com
- HTN_CONSUMER_KEY
  - get [here](http://developer.hatena.ne.jp/)
- HTN_CONSUMER_SECRET
  - get [here](http://developer.hatena.ne.jp/)
- HTN_ACCESS_TOKEN
  - follow [this instruction](https://github.com/kymmt90/hatenablog#2-get-your-access-token-and-access-token-secret)
- HTN_ACCESS_TOKEN_SECRET
  - follow [this instruction](https://github.com/kymmt90/hatenablog#2-get-your-access-token-and-access-token-secret)

## Rails

- SECRET_KEY_BASE
  - any

# Run

```bash
$ git clone git@github.com:dogwood008/fetch_hatena_bookmark_and_post_to_hatena_blog.git
$ bundle install
$ bundle exec rake db:migrate
$ bundle exec rake db:seed
$ HTN_USER_ID=hogefugapiyo HTN...=... SECRET_KEY_BASE=foobarbaz RAILS_ENV=production bundle exec rails s -b 0.0.0.0
```

# Git Commit Messages

- 🎨  `:art:` when improving the format/structure of the code
- 🐎  `:racehorse:` when improving performance
- 🚱  `:non-potable_water:` when plugging memory leaks
- 📝  `:memo:` when writing docs
- ➕  `:heavy_plus_sign:` when adding some features
- ➖  `:heavy_minus_sign:` when removing some features
- 🐧  `:penguin:` when fixing something on Linux
- 🍎  `:apple:` when fixing something on macOS
- 🏁  `:checkered_flag:` when fixing something on Windows
- 🐛  `:bug:` when fixing a bug
- 🔥  `:fire:` when removing code or files
- 💚  `:green_heart:` when fixing the CI build
- ✅  `:white_check_mark:` when adding tests
- 🔒  `:lock:` when dealing with security
- ⬆️  `:arrow_up:` when upgrading dependencies
- ⬇️  `:arrow_down:` when downgrading dependencies
- 👕  `:shirt:` when removing linter warnings
