
## Welcome to Eldac

Eldac is an ELectronic DAta Capture tool.

## Getting Started

1. Copy database settings example:

		$ cp config/database.yml-example config/database.yml

2. Install gems:

		$ bundle install

3. Run:

		$ bundle exec rails s

4. Using a browser, go to `http://localhost:3000`.

		w0oh0o! :)

5. Run tests:

		BROWSER=chrome SELENIUM=true bundle exec rake

## Status

[![Build Status](https://travis-ci.org/gdonald/eldac.svg?branch=master)](https://travis-ci.org/gdonald/eldac) [![Test Coverage](https://codeclimate.com/github/gdonald/eldac/badges/coverage.svg)](https://codeclimate.com/github/gdonald/eldac/coverage) [![Code Climate](https://codeclimate.com/github/gdonald/eldac/badges/gpa.svg)](https://codeclimate.com/github/gdonald/eldac)

## License

Eldac is released unde the [MIT License](http://www.opensource.org/licenses/MIT)
