# Youzanyun

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/youzanyun`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'youzanyun'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install youzanyun

## Usage

```
require "bundler/setup"
require "youzanyun"
require "redis"
require "redis-namespace"
redis = Redis.new(host: 'localhost', port: 6379, db: 2)
youzanyun_redis = Redis::Namespace.new("youzanyun", :redis => redis)
Youzanyun.configure do |config|
  config.redis = youzanyun_redis
  config.rest_client_options = {:timeout => 100, :read_timeout => 1000, :open_timeout => 100, :verify_ssl => true,:headers => { :content_type => 'application/json' }}
end

$client_youzanyun ||= Youzanyun::Client.new(
    "client_id",
    "client_secret",
    "grant_id"
)
$client_youzanyun.get_access_token
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/youzanyun.
