# QuakeliveApi

[![Code Climate](https://codeclimate.com/github/emq/quakelive_api.png)](https://codeclimate.com/github/emq/quakelive_api)
[![Build Status](https://travis-ci.org/emq/quakelive_api.png?branch=master)](https://travis-ci.org/emq/quakelive_api)
[![Coverage Status](https://coveralls.io/repos/emq/quakelive_api/badge.png)](https://coveralls.io/r/emq/quakelive_api)
[![Dependency Status](https://gemnasium.com/emq/quakelive_api.png)](https://gemnasium.com/emq/quakelive_api)

This gem fetches (basic) publicly available data from [QuakeLive site][1]. Unfortunately currently there is no real API provided by ID so we're forced to parse html to get what we can. It will go down in flames if QL changes its internal html structure, so be prepared for that too.

The dirty job is made under `Parser` module (nothing pretty there, but response from QL is not pretty as well).

It is currently used in production environment, but consider it as work in progress for you own safety.

**NOTE:** QuakeLive is going standalone (Windows only), this will probably break this gem in near future (end of '13).

## Installation

Add this line to your application's Gemfile:

    gem 'quakelive_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quakelive_api

## Usage

There is a main class called `QuakeliveApi::Profile` that will accept *player_name* (nickname from QL) as argument.
This class delegates its methods to other classes that *speaks* with quakelive.com. Each method call will execute a single query (using standard `Net::HTTP` Ruby library), parse the response using `Nokogiri` and returns the result (cached as instance variables).

Usage:

``` ruby
profile = QuakeliveApi::Profile.new(player_name)

profile.summary           # instance variable of QuakeliveApi::Profile::Summary
profile.statistics        # instance variable of QuakeliveApi::Profile::Statistics
profile.awards_milestones # instance variable of QuakeliveApi::Profile::Awards::CareerMilestones
profile.awards_experience # instance variable of QuakeliveApi::Profile::Awards::Experience
profile.awards_skillz     # instance variable of QuakeliveApi::Profile::Awards::MadSkillz
profile.awards_social     # instance variable of QuakeliveApi::Profile::Awards::SocialLife
profile.awards_success    # instance variable of QuakeliveApi::Profile::Awards::SweetSuccess

# there is also helper method called .each_award that will execute given block for all awards
# Note: those classes can be used separately (the initializer argument is the same)

# calling those methods may raise:
# - QuakeliveApi::Error::PlayerNotFound on invalid player_name
# - QuakeliveApi::Error::RequestError when ql site returns 'An Error Has Occurred' page
```

### Methods (should be self-explanatory)

- `QuakeliveApi::Profile::Summary`: country, nick, clan, model, memeber_since, last_game, time_played, wins, accuracy, losses, quits, frags, deaths, hits, shots, favourite, recent_awards, recent_games, recent_competitors

- `QuakeliveApi::Profile::Statistics` - weapons, records (each is array of _Struct_ objects)

- `QuakeliveApi::Profile::Awards` (each kind) - earned, unearned (same as above)

## Known issues

- I noticed that sometimes QL site returns incomplete response for awards, that will trigger exception inside parser, unfortunately I can't quite narrow it down atm :(

## TODO

- RDoc?
- it would be great to provide support for all stats like matches, competitors, friends etc.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[1]: http://quakelive.com
