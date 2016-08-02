# DX::Lookup

Easy callsign and DXCC entity lookup utilizing third-party APIs. 

Currently-supported APIs:

* QRZ.com

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dx-lookup'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dx-lookup

## Usage

### QRZ.com Lookup

You must have a subscription to the "XML Logbook Data" subscription on QRZ.com. Go to [your account page](https://www.qrz.com/manager) to subscribe.

It is highly recommended that you store your QRZ.com username externally to your source files, for example in a configuration file, or in your environment variables.

```ruby
qrz = DX::Lookup::QRZ.new(ENV['QRZ_USERNAME'], ENV['QRZ_PASSWORD'])

call = qrz.get_callsign('W1AW')
puts call.last_name # => 'ARRL HQ OPERATORS CLUB'
puts call.dxcc # => 291
puts call.grid # => 'FN31pr'

entity = qrz.get_dxcc_entity(291)
puts entity.name # => 'United States'

entity = qrz.get_callsign_entity('OH8X')
puts entity.name # => 'Finland'

entities = qrz.get_all_entities
puts entities.count # => 399
```

See `lib/dx/lookup/qrz/callsign.rb` and `lib/dx/lookup/qrz/entity.rb` for a complete list of supported attributes.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/schrockwell/dx-lookup.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).