# TechCrawler

Crawl a list of domains and attempt to detect technologies used.

`TechCrawler` uses a plugin system, located in `lib/tech_crawler/plugins`,
where each plugin must respond to `#call` and return a `boolean` whether a
particular technology was detected.

`TechCrawler` attempts to detect as many technolgies as possible on the first
request to the root path of the domain, ex. google.com. For a given domain
this will generate at most 1 HTTP request for `N` plugins.

If a technology is not detected on the root path of the domain, an additional
request is generated for each plugin that responds to `#path`, generating at
most 1 request per plugin/path.

## Technical notes and caveats

* HTTP request configuration is located in `lib/tech_crawler/configuration.rb`
with the following defaults:
 - Request gzip encoding of responses
 - Accept cookies
 - A Firefox user-agent header which may run afoul of [proper scraping etiquette](http://meta.stackexchange.com/a/446).
* `max_concurrency` is currently hard-coded at 20 in `lib/tech_crawler/crawler.rb`.
  *Things will get flakey if you try to make too many requests at the same time. [The built in limit is 200](https://github.com/typhoeus/typhoeus#specifying-max-concurrency).*
* Unit tests for each plugin are located in `spec/plugins`
* Integration tests for each plugin are located in `spec/crawler`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tech_crawler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tech_crawler

## Usage

```
Usage: crawl [options]
        --size [SIZE]                Select crawl size (10, 50, 1k, 1M)
    -h, --help                       Prints this help
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bds/tech_crawler. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
