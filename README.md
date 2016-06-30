# CheckChefConverge

This is a Nagios/Sensu check that can check if nodes returned from a chef search
have converged recently.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'check_chef_converge'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install check_chef_converge

## Usage

```
Usage: check_chef_converge
    -w, --warn-minutes MINUTES       Warning when chef has not converged in minutes.Default 65
    -c, --crit-minutes MINUTES       Critical when chef has not converged in minutes.Default 70
    -q, --query SEARCH               Chef query to filter on. Default 'fqdn:travis-work-mbp.local'
        --chef-client-config CONFIG  Chef client configuration.
        --chef-server-url URL        Chef Server URL. Must pass client-name and client-key or client-key-file with this option.
        --chef-client-name NAME      Chef Client Name. Only used with  server-url
        --chef-client-key KEY        Chef Client Key (string). Only used with  server-url. Takes precedence over client-key-file.
        --chef-client-key-file PATH  Chef Client Key File. Only used with  server-url
    -h, --help                       Show this message
        --version                    Show version
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Altiscale/check_chef_converge. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

