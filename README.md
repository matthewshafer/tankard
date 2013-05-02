# Tankard
[![Build Status](https://travis-ci.org/matthewshafer/tankard.png?branch=master)](https://travis-ci.org/matthewshafer/tankard)
[![Dependency Status](https://gemnasium.com/matthewshafer/tankard.png)](https://gemnasium.com/matthewshafer/tankard)
[![Code Climate](https://codeclimate.com/github/matthewshafer/tankard.png)](https://codeclimate.com/github/matthewshafer/tankard)
[![Coverage Status](https://coveralls.io/repos/matthewshafer/tankard/badge.png?branch=master)](https://coveralls.io/r/matthewshafer/tankard)

Allows easy quering of the BreweryDB Api

## About

I decided to make Tankard for a personal project and then figured why not put it on github as I am working on it.
Tankard is very immature at the moment.  I plan on adding support for all of the get routes to the BreweryDB Api.
I've also been pretty interested in Jruby as of late and wanted to make Tankard thread safe.

## Installation

Soon...

## Documentation

Soon...

## Usage

If you happen to be using Rails you can do the configuration in an initializer, something like:

```ruby
require 'tankard'

Tankard.configure do |config|
  config.api_key = "YOUR_API_KEY"
end
```

After being configured this is a sample of ways to use Tankard:

### Beer

```ruby
Tankard.beer.id("some_id").breweries.each { |x| p x}

beer = Tankard.beer.find(["first_id", "second_id"])
```

## Contributing

### Issues

Issues can be reported right here on the git repo.
Everyone is encouraged to write an issue if they encounter a bug or have a feature request.

### Pull Requests

I will be accepting pull requests once I get most of the endpoints implemented.
Check back soon for more details.