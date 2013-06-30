# QuakeliveApi

** !! Work in progress !! **

This gem fetches publicly available data from [QuakeLive site][1]. Unfortunately currently there is no real API provided by ID so we're forced to parse html to get what we can. It will go down in flames if QL changes its internal html structure, so be prepared for that too (even tho I don't think there is a big change of that happening).

The dirty job is made under `Parser` module (nothing pretty there, but response from ql is not pretty as well).

## Installation

Add this line to your application's Gemfile:

    gem 'quakelive_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quakelive_api

## Usage

*Profile info*

Usage:

``` ruby
profile = QuakeliveApi::Profile.new(player_name)

profile.summary    # instance variable of QuakeliveApi::Profile::Summary
profile.statistics # instance variable of QuakeliveApi::Profile::Statistics

# Note: those classes can be used separately

# calling summary / statistics may raise:
# - QuakeliveApi::Error::PlayerNotFound on invalid player_name
# - QuakeliveApi::Error::RequestError when ql site returns 'An Error Has Occurred' page
```

List of available methods coming soon (I hope). Please take a look at the code for now.

Summary class provides:

_TODO_

Statistics class provides:

_TODO_

Note: The values are cached using instance variables, but it's totally up to you how you want to implement real caching in your application.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[1]: http://quakelive.com
