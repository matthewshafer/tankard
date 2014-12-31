# Tankard
[![Build Status](https://travis-ci.org/matthewshafer/tankard.svg?branch=master)](https://travis-ci.org/matthewshafer/tankard)
[![Dependency Status](https://gemnasium.com/matthewshafer/tankard.svg)](https://gemnasium.com/matthewshafer/tankard)
[![Code Climate](https://codeclimate.com/github/matthewshafer/tankard/badges/gpa.svg)](https://codeclimate.com/github/matthewshafer/tankard)
[![Coverage Status](https://img.shields.io/coveralls/matthewshafer/tankard.svg)](https://coveralls.io/r/matthewshafer/tankard?branch=master)
[![Gem Version](https://badge.fury.io/rb/tankard.svg)](http://badge.fury.io/rb/tankard)
[![Inline docs](http://inch-ci.org/github/matthewshafer/tankard.svg?branch=master)](http://inch-ci.org/github/matthewshafer/tankard)

Allows easy quering of the BreweryDB Api

## About

I decided to make Tankard for a personal project and then figured why not put it on github as I am working on it.
Tankard is very immature at the moment.  I plan on adding support for all of the get routes to the BreweryDB Api.
I've also been pretty interested in Jruby as of late and wanted to make Tankard thread safe.

## Installation

```ruby
gem install "tankard"
```

or add it to your gemfile

## Documentation

Everytime a commit is pushed to github the documentation regenerates.
You can find this at http://rubydoc.info/github/matthewshafer/tankard/frames

If you visit rubygems you can find the documentation for a specific gem release.

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

Alternatively you can send parameters to the request in two ways.  Here are examples:

```ruby
Tankard.beer(id: "some_id", endpoint: "breweries", anotherParam: "something").each { |x| p x }

Tankard.beer.id("some_id").breweries.params(anotherParam: "something").each { |x| p x }
```

### Beers

This would return an array with all beers greater than 10% (to_a comes from enumerable in this case)

```ruby
Tankard.beers.params(abv: "+10").to_a
```
### Search

Here is how we could search for everything that matches "stone".
We would get results that contain more than just beer (EX I would probably get a result for Stone Brewing)

```ruby
Tankard.search.query("stone").each { |x| p x }
```
### Style

This works similiar to Beer, it just has less options

```ruby
Tankard.style.id("some_id").each { |x| p x }
```

### Styles

Styles don't have any options so if I would like an array with all styles I can do something like

```ruby
Tankard.styles.to_a
```

## Contributing

### Issues

Issues can be reported right here on the git repo.
Everyone is encouraged to write an issue if they encounter a bug or have a feature request.

### Pull Requests

I will be accepting pull requests once I get most of the endpoints implemented.
Check back soon for more details.
